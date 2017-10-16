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
1. boot up unicorn processes
2. unicorn -c /opt/unicorn.rb -E development -D
3. disable selinux to allow nginx and unicorn share socket


# Iteration 4
Goal: Automate the production like environment provisioning
1. Ansible roles for proxy (nginx), ruby, unicorn

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
Goal: Security uplift and documentation
1. Update the system with latest security patches
2. Use nginx official repo instead of epel-release
3. Load artefact from s3 rather than github
4. Remove unneeded package and services

# Iteration 10
Goal: further secure the app
1. Run ansible as non-root, file permissions
2. SElinux policy to allow socket share
3. Enable firewalld to filter packets

# Backlog  
Support centos and ubuntu
Template to support 2 tiers
Shorten time for installing ruby
Log rotate, centralised logging
S3 Yum repo setup
