# Deploy a sinatra app

### Setup local environment

Use vagrant and virtualbox to provision the local environment, so we can have a working environment setup quickly.    
The Image used for this application is centos7 vagrant box, which can be downloaded from here: https://app.vagrantup.com/centos/boxes/7

The centos7 vagrant box version: v1708.01  
The virtualbox version: 5.1.28

Edit `local_vagrant_settings.rb`

local_vagrant_settings has defined the vagrant box, CPU and Memory required and the ports required mapping to the guest machine.

By default port 80 from the vagrant machine has mapped to port 8000, therefore, once the server is up, you can access the website at http://127.0.0.1:8000

To get the vagrant box up and running, go to the root directory of this repository and type command:  

```
$ vagrant up
```
**Troubleshooting**

For mount shared folder error:  
`vagrant plugin install vagrant-vbguest`


**Ansible playbook and roles**

Why use ansible as config management tool?
Ansible is quick to setup and running in local and AWS environment
Ansible roles can be reused in both environment

Vagrant will run with playbook-vagrant.yml with below roles:  
- local
  Install the basic dependencies
- ruby
  Install ruby package
- unicorn
  Install and config unicorn
- proxy
  Install and config nginx to work as a reverse proxy
- app
  Copy the app files to the target location

**Run system tests**

```
$ cd /repo/system
$ bundle install
$ rake spec

```

**Test app**

```
curl 127.0.0.1
```

### Setup AWS environment

**Prerequisite**

The assumption is, you already have an AWS VPC setup in your AWS account, and you should have following architecture in your VPC

![AWS](design/aws_vpc.jpg)

Can use AWS Net Gateway instead of a Net Instance

Network ACL:  
- Inbound:  
Allow TCP Port 80 - 443  
Allow SSH Port 22  

Security Groups:  
- ELB-sg: allow HTTP 80  
- Jumpbox: allow TCP 22  
- App-sg: allow TCP 22 from jumpbox sg, allow HTTP 80 from ELB-sg  

Route table:  
- For Public subnets:  
  10.0.0.0/16 local  
  0.0.0.0/0   igw-x  

For private subnets:  
10.0.0.0/16 local  
0.0.0.0/0   nat-x  

Edit `aws_settings.yml` with above settings


**Install this package**

$ virtualenv venv

$ source venv/bin/activate

$ pip install -r requirements.txt

$ pip install -e .


**Run unittest**

$ python -m unittest tests.test_cf_generator


**Run the stack**

Require aws credetials setup locally

$ stack -i aws_settings.yml


### Build AWS AMI to install the basics prior to app deploy

Require packer installed

scripts/build_ami.sh


### Security uplift

Securiy part has implemented on AWS environment only, because the local environment require faster boot and feedback

- Use nginx official YUM repo instead of epel-release
- Remove unnecessary software packages
- Remove unneeded services
- Update the system with latest security patches
- Enable selinux
