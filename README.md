# Deploy a sinatra app

### Setup local vagrant environment

Edit `local_vagrant_settings.rb`

$ vagrant up


### Setup AWS environment

Edit `aws_settings.yml`

**Install this package**

$ virtualenv venv
$ source venv/bin/activate

$ pip install -r requirements.txt
$ pip install -e .

$ stack -i aws_settings.yml
