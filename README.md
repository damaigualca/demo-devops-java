# Demo Devops Java

This is a simple application to be used in the technical test of DevOps.

This project demonstrates how to build and deploy an application using Docker, Kubernetes, Terraform, ArgoCD, and Jenkins for continuous integration and delivery, and Prometheus and Grafana for monitoring.

## Quick Start

### Prerequisites

- Java 17
- Spring Boot 2.5.0
- Maven
- Docker
- Kubernetes
- Terraform
- ArgoCD
- Jenkins
- Prometheus
- Grafana	

### Guides and Additional Resources

- [Project Guide Document](https://docs.google.com/document/d/1p-QZU0v1oAbiYLWB1rzMHTI0POcej_bm9jAtGw_W23A/edit?usp=sharing)
- [ArgoCD Continuous Delivery Project on GitHub](https://github.com/damaigualca/argo-master.git)


### Installation

Clone this repo.

```bash
git clone https://github.com/damaigualca/demo-devops-java.git
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `test.mv.db`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
mvn clean test
```

To run locally the project you can use this command.

```bash
mvn spring-boot:run
```

Open http://127.0.0.1:8000/api/swagger-ui.html with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "errors": [
        "User not found: <id>"
    ]
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

#### Building and Deploying the Docker Container

1. Generate the project's JAR file by running `mvn clean package`.
2. Create the Dockerfile for your application.
3. Build the Docker image with `docker build -t app-demo-devsu:1.0 .`.
4. Create the docker-compose.yml file.
5. Generate the image with `docker-compose build`.
6. Launch the Docker container.

#### Deployment on Azure with Terraform and Kubernetes

1. Use Terraform to create a resource group and configure the Kubernetes cluster in Azure.
2. Create a Kubernetes Secret for authentication with the Container Registry.
3. Upload the Docker image to the Container Registry.

#### Configuring ArgoCD for Continuous Delivery

1. Create a project on GitHub for the ArgoCD configuration.
2. Set up the ArgoCD project.
3. Verify the creation of deployments, pods, replica sets, and the load balancer in the cluster.

#### Configuring Jenkins and SonarQube for Continuous Integration

1. Create the Jenkinsfile to set up the Jenkins pipeline.
2. Configure the Pipeline in Jenkins.
3. Set up SonarQube for code quality analysis.

#### Configuring Prometheus and Grafana for Monitoring

1. Install and configure Prometheus.
2. Install Grafana for monitoring.
3. Set up the Grafana dashboard to connect it with Prometheus and monitor the metrics of the Spring Boot container.
4. Configure alerts in Grafana.
5. Access Grafana on your local machine by doing a port-forward to the Grafana pod.


## License

Copyright © 2023 Devsu. All rights reserved.
