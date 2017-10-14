module LocalVagrantSettings

  # Resources to allocate to the VM's
  VM_CPUS=2
  VM_MEMORY=2048

  #The name of the vagrant base boxes to use
  CENTOS_7_BOX     = "centos/7"


  # Set this to true to use NFS for the shared folders listed above for faster performance
  # The host needs to have nfsd installed (OS X comes with nfsd installed by default)
  USE_NFS = "false"

  # This will prevent you running multiple machines at the same time,
  # forwarded ports and multiple VM's are required.
  FORWARDED_PORTS = {
   9292 => 8080,
   4567 => 8085
  }

end
