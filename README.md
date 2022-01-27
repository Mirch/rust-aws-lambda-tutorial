# Rust on AWS Lambda - tutorial


This repository provides examples on how to run Rust on AWS Lambda.

## Series explaining the process
1. [CRUD operations with Rust on AWS Lambda: Part 1](https://mirceaoprea.medium.com/serverless-crud-operation-with-rust-on-aws-part-1-578146d52946) - how to deploy a basic Rust function to AWS Lambda.  
2. [CRUD operations with Rust on AWS Lambda: Part 2](https://mirceaoprea.medium.com/crud-operations-with-rust-on-aws-lambda-part-2-bd1feae2554b) - how to deploy multiple functions with Terraform
  
### Incoming:   
3. CRUD operations with Rust on AWS Lambda: Part 3 - how to interact with other services from Rust


## Repository structure

The `./basic-function` folder contains the code for the Rust function developed in the first part of the series. The pipeline for deploying this function to AWS can be found in `./github/workflows/basic-function-pipeline.yml`.
