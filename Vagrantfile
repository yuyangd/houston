require_relative 'local_vagrant_settings.rb'
include LocalVagrantSettings

def configure_provider(config)
  # Configure the VM provider
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", VM_MEMORY]
    vb.customize ["modifyvm", :id, "--cpus", VM_CPUS]
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end
end

def configure_ansible(config)
  # Configure Ansible as the provisioner for the VM
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "ansible/playbook-vagrant.yml"
    ansible.install_mode = "pip"
    ansible.version = "2.4.0.0"
  end
end

def configure_network(config)
  # Configure private network to allow guest access
  config.vm.provider :virtualbox do |vb|
    #config.vm.network "private_network", :type => 'dhcp', :name => 'vboxnet0', :adapter => 2
    if defined?(FORWARDED_PORTS)
      FORWARDED_PORTS.each do |guest_port, host_port|
        config.vm.network "forwarded_port", guest: "#{guest_port}", host: "#{host_port}"
      end
    end
  end
end

Vagrant.configure("2") do |vagrant_config|

  vagrant_config.vm.define :centos_7 do |config|
    config.vm.box = CENTOS_7_BOX
    configure_provider(config)
    configure_network(config)
    configure_ansible(config)
  end

  if Vagrant.has_plugin?(:vbguest)
    # set auto_update to false, if do NOT want to check the correct additions
    # version when booting this machine
    vagrant_config.vbguest.auto_update = false

    # do NOT download the iso file from a webserver
    vagrant_config.vbguest.no_remote = true
  end

  vagrant_config.vm.synced_folder "ansible", "/repo/ansible"
  vagrant_config.vm.synced_folder "tests", "/repo/tests"

end
