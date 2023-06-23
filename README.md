## About

The goal of this work is to automate the setup and management of the infrastructure so that users can focus on building their WordPress sites without worrying about the underlying technolog

The project includes GitHub Actions pipelines for deploying Kubernetes, configuring MySQL, and deploying WordPress on Azure using the Tekton tool. Each WordPress instance is set up as a read-only image with its own URI and SSL, and can be replicated as needed to handle different levels of traffic. WordPress instances can also be updated easily with new plugins or themes, and Tekton will automatically build and deploy the new version.

Thank you for your interest in WordPress Cloud at K8S!

### Built With

The project is built using the following technologies:

- [Tekton](https://tekton.dev/): A Kubernetes-native open-source framework for creating continuous integration and delivery (CI/CD) systems.
- [Kubernetes](https://kubernetes.io/): An open-source container orchestration platform for automating the deployment, scaling, and management of containerized applications.
- [Microsoft Azure](https://azure.microsoft.com/): A suite of cloud computing services provided by Google, including compute, storage, networking, and more.
- [WordPress](https://wordpress.org/): A popular open-source content management system (CMS) for creating websites and blogs.
- [Terraform](https://www.terraform.io/): An open-source infrastructure as code software tool that enables you to define and provision infrastructure resources using declarative configuration files.
- [Docker](https://www.docker.com/): An open-source platform that allows you to automate the deployment, scaling, and management of applications using containerization.

These technologies work together to provide a robust and scalable solution for deploying and managing WordPress instances in the cloud. Tekton is used for creating CI/CD pipelines, Kubernetes handles the container orchestration, cloud provides the underlying cloud infrastructure, WordPress powers the content management, and Terraform and Docker are used for infrastructure provisioning and containerization, respectively.


## You can see last status of deployments:

Status of Last Deployment:<br>

<img src="https://github.com/IgorPostavnichiy/Wordpress-inAzurecloud-at-k8s/workflows/Deploy Terraform K8S Azure/badge.svg?branch=main"><br>

Status of Last Deployment with Tekton:<br>

<img src="https://github.com/IgorPostavnichiy/Wordpress-inAzurecloud-at-k8s/workflows/Deploy Terraform K8S Azure with Tekton/badge.svg?branch=main"><br>



