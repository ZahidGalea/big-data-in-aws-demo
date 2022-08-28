#bin/bash

cd application-folder

minikube delete
minikube start --memory 11000 --cpus 6 --insecure-registry "10.0.0.0/24"
minikube addons enable registry
export MNK_REGISTRY_IP=$(kubectl -n kube-system get svc registry -o jsonpath='{.spec.clusterIP}')

kubectl create ns debezium-example
kubectl config set-context --current --namespace=debezium-example
kubectl create configmap filler-app-db-creation --from-file=database/startup-scripts/db.creation.sh
kubectl apply -f database/db.yml
eval $(minikube docker-env)
docker build -t=logistic-app:latest filler-application/
eval $(minikube docker-env)
docker build -t=simulation-logistic-app:latest filler-application/simulation_app/
kubectl apply -f secrets/postgre-db-secret.yml
kubectl apply -f filler-application/filler-application.yml
kubectl apply -f filler-application/transaction-simulation.yml
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.20.0/install.sh | bash -s v0.20.0
kubectl create -f https://operatorhub.io/install/strimzi-kafka-operator.yaml
sleep 60
kubectl create -n debezium-example -f kafka/kafka.yml
sleep 60
envsubst <kafka/kafka-connect.yml | kubectl apply -n debezium-example -f -
kubectl apply -f kafka/dbz-connector.yml

cd ..
