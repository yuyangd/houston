# Deploy a sinatra app

### Setup local vagrant environment

Edit `local_vagrant_settings.rb`

$ vagrant up


### Setup AWS environment

**Prerequisite**

Edit `aws_settings.yml`
Require basic aws environment settings
Public subnets for ELB, private subnets for app instances
Net Gateway in Public subnets
Routing tables


**Install this package**

$ virtualenv venv

$ source venv/bin/activate

$ pip install -r requirements.txt

$ pip install -e .

**Run the stack**
$ stack -i aws_settings.yml
