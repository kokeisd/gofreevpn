$script = <<-SCRIPT
    stop-service wuauserv
    set-service wuauserv -startup disabled
SCRIPT
  
  Vagrant.configure(2) do |config|
  #config.vm.box = "inclusivedesign/windows10-eval" 
  config.vm.box = "senglin/win-10-enterprise-vs2015community"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.vm.boot_timeout = 600
  config.vm.network :forwarded_port, guest: 3389, host: 3388
  # config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "false", path: "scripts/devboxsetup.ps1"  
  #config.vm.provision "file", source: "/", destination: "c:\\gofreevpn\\"
  #config.vm.provision "shell", inline: "stop-service wuauserv"
  #config.vm.provision "shell", inline: "set-service wuauserv –startup disabled"
  config.vm.provision "shell", privileged: "true",  inline: $script
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.name = "Win10"
  end
 
end