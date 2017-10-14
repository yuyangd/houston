# Requirements

Provision an app server.

Deploy the app to local
Deploy the app to AWS


# Prerequisite
Local environment: virtualbox

Local base image vagrant box centos/7 1708.01


# Iteration 1
Goal: Get the app running in a vagrant box locally
1. Setup vagrant box to run centos7
2. Install ruby and deps
  - install ruby gem bundler sinatra
3. Manually run ruby app and test


# Iteration 2
Goal: Automate a base installation prior to get the app running
1. Setup Ansible as provisioner
2. Add playbook-vagrant
3. Add ansible roles: ruby, to install ruby and deps
4. Manually run ruby app and test

# Iteration 3
Goal: Manually run the app in a production like environment with nginx and unicorn



# Iteration 4
Goal: Automate the production like environment provisioning


# Iteration 5
Goal: Get a basic CloudFormation template to setup the environment
1. Generate a template with 1 tier only
2. some tests for the template

# Iteration 6
Goal: Bake an AMI to have some basic things installed


# Iteration 7
Goal: Enable ansible playbook to run on AWS
      Have some system tests in place to run locally

# Iteration 8
Goal: use userdata to fetch the code
      provision the server
      deploy the app

# Iteration 9
Goal: Write README.md

# Backlog
Support centos and ubuntu
Template to support 2 tiers
