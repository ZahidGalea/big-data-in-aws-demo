#bin/bash

cd application-demo

# Restar a minikube if it exists
minikube delete
minikube start --memory 11000 --cpus 6 --insecure-registry "10.0.0.0/24"
minikube addons enable registry

# Saves this variable to save the debezium connector image
kubectl create ns debezium-example
kubectl config set-context --current --namespace=debezium-example

# Create the postgreDB
kubectl create configmap filler-app-db-creation --from-file=database/startup-scripts/db.creation.sh
kubectl apply -f database/db.yml
eval $(minikube docker-env)

# Creates a postgreDB filler app
docker build -t=logistic-app:latest filler-application/
docker build -t=simulation-logistic-app:latest filler-application/simulation_app/
kubectl apply -f secrets/postgre-db-secret.yml
kubectl apply -f filler-application/filler-application.yml
# This app holds how many request and what record sends the app to
kubectl apply -f filler-application/transaction-simulation.yml

# Install strimzi
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.20.0/install.sh | bash -s v0.20.0
kubectl create -f https://operatorhub.io/install/strimzi-kafka-operator.yaml
echo "Sleeping for 2 minutes"
sleep 120
# Creates a kafka cluster
kubectl create -n debezium-example -f kafka/kafka.yml
echo "Sleeping for 2 minutes"
sleep 120

# Creates the kafka connector
export MNK_REGISTRY_IP=$(kubectl -n kube-system get svc registry -o jsonpath='{.spec.clusterIP}'); envsubst <kafka/kafka-connect.yml | kubectl apply -n debezium-example -f -
sleep 120
# Creates the debezium connector
kubectl apply -f kafka/dbz-connector.yml