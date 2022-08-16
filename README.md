# Big Data in AWS

This project holds a Demo in AWS using Glue and Redshift and some other things:


## What is my plan?

1) Setting up some resources in AWS using Terraform:
2) Have up a service for Publishing and subscribers
   1) Write that data to an Storage
      1) Process that data to have batch analytics
   2) Get this data and make a Near real time analytics dashboard
3) Crete a replication of PostgresSQL Database to Kafka in near real-time using Debezium.

---

## Objective architecture

![asd](https://d2908q01vomqb2.cloudfront.net/b6692ea5df920cad691c20319a6fffd7a4a766b8/2021/02/19/data-analytics-update-2-final.jpg)

## Demo

* **Requirements**:
  * add a credentials.tfvars with the following values in the desired terraform folder or complete trough input:
    * secret_key = "XXX"
    * access_key = "YYY"


* Plan the infrastructure and then apply it
   ```bash
   make infrastructure_aws_bigdata_demo
   ```
