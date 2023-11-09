# Automated DevOps Project
# ( Flask web application and redis )

## Introduction
This project focuses on automating the deployment of a Flask web application and redis database using Docker file and docker containers . The deployment process is streamlined by leveraging a combination of Terraform for infrastructure provisioning ( eks cluster and ec2 for jenkins server), Ansible for jenkins server configuration, and Jenkins for continuous integration and deployment (CI/CD), all orchestrated by Kubernetes eks for container management.

## Tools

- GIT
- github
- Docker
- Dockerhub
- Kubernetes
- EKS
- Terraform
- AWS 
- Ansible
- Jenkins

---
## Project Organization

The project is divided into distinct phases, each catering to a specific facet of the infrastructure:

- **Containerization**: Crafting Dockerfiles for the Flask app and redis database
- **Terraform Enactment**: Defining integral infrastructure elements like VPC, subnets, EC2 instance for jenkins server , ECR repository , EKS cluster, and more.
- **Ansible Automation**: Facilitating the configuration of the EC2 instance (jenkins server) by installing Jenkins, AWS CLI, kubectl, and Docker.
- **Kubernetes Proficiency**: Developing Kubernetes manifests to deploy the Flask app and redis database on the EKS cluster.
- **Jenkins Pipeline Mastery**: Setting up a Jenkins pipeline to automate build, push, and deployment activities.
- **bash scripting**: automating the cycle with bash


## Step-by-Step Walkthrough

### 0. Prerequisites ###
- github account
- aws account with aws access keys and aws key pairs
- ubuntu machine with ansible and terraform 

### 1. Automate Infrastructure and Dependencies ###

Clone the repository:
```bash
git clone https://github.com/mahmoudsaleh74/cicd-python-app.git
```

Navigate to the project directory:
```bash
cd cicd-python-app
```
### 1.1 terraform Dependencies

edit terraform main file (line 62 ) with your aws key pair name ( required to provisin ec2 ) :
```bash
vim terraform/main.tf
```

Configure Your Access-Secret key as terraform profile with profile name "myprofile":
```bash
aws configure
```
### 1.2 ansible Dependencies
Put Your Aws Key Pair File (.pem) In the project directory ( required for ansible to access ec2 ):
```bash
copy <example.pem> to <cicd-python-app>
```

edit script.sh (line 7) with aws key pair name( required for ansible to access ec2 ):
```bash
vim script.sh
```

Put Your Aws Access - Secret Key in file ( required to configure aws-cli on ec2):
```bash
vim ansible/roles/aws-cli/vars/main.yml
```

### 1.3 run script.sh
modify permissions:
```bash
chmod +x script.sh
```

run script:
```bash
./scipt.sh
```


### 2. configure jenkins ###

### 2.1 access jenkins
2.1.1 open:
```bash
<ec2-ip>:8080
```
- 2.1.2 put admin password from script output
- 2.1.3 Install Plugins: Click "Install suggested plugins" and wait for the installation to finish.
- 2.1.4 Create User: Create a user with necessary information.
- 2.1.5 Start Jenkins: Click "Start Jenkins".

### 2.2 Add GitHub and AWS Keys 

2.2.1 dockerhub Key:

- Go to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add credentials.
Use Username with password, scope Global.
- Provide your dockerhub username in username field and token in password field.
- ID: docker-hub

2.2.1 AWS Key:
- install plugin "pipeline: aws steps"
- Go to Manage Jenkins > Credentials > System > Global credentials (unrestricted) > Add credentials.
Use aws credentials, scope Global.
- Provide your AWS Access Key id and Secret Key
- ID: aws-cli


### 3. configure jenkins pipeline ###
### don't forget to edit jenkins file with your dockerhub repo then push the project to your github repo #

### 3.1 configure webhook for github

3.1.1 Create a Webhook:
- Go to your GitHub repository.
- Click on "Settings" tab.
- Click on "Webhooks" in the left sidebar.
- Click the "Add webhook" button.

3.1.2 configure Webhook:
- Payload URL: This is the URL of your Jenkins server's webhook endpoint. It usually looks like http://ip_server:8080/github-webhook/.
- Content type: Set it to application/json.
- Which events would you like to trigger this webhook?: Choose the events that should trigger the Jenkins build. Typically, you might select "Push events" for any code pushes to the repository.
- Click the "Add webhook" button to save your webhook configuration.

### 3.2 configure jenkins job 
- In Jenkins Page Click Create Job
- In Enter an item name Field Put Any Name For Pipeline
- Choose Pipeline
- build triggers : choose github hook trigger from gitscm polling
- pipeline: pipeline script from scm >> scm: git >> put your repo url >> branch: */master >>
scipt path: Jenkinsfile

### 4. test project ###
- run jenkins job
- navigate to job console 
- copy website url and open it in the browser  


## In Conclusion

#### This comprehensive DevOps infrastructure deployment endeavor underscores the amalgamation of diverse tools and technologies, culminating in a seamless end-to-end deployment procedure. By following the structured guide, you have effectively established a sturdy pipeline for constructing, deploying, and managing a Flask web application and redis database on AWS with Kubernetes. This undertaking establishes a robust basis for refining and enhancing your DevOps practices.

#### You're encouraged to further explore and optimize each component, tailoring the project to your unique requirements. Here's to successful deployments!
