# Vars
ipNet = "192.0.2."
machines = {
  "ans-rd" => { "image" => "bento/ubuntu-20.04", "memory" => "3072", "cpus" => "2", "ipHost" => "10" }
  # "ans-rd" => { "image" => "bento/ubuntu-20.04", "memory" => "3072", "cpus" => "2", "ip" => "10" },
}

$createInventory = <<-'SCRIPT'
cat <<EOF >> /etc/ansible/hosts
[$1]
$2

EOF
SCRIPT

$createHosts = <<-'SCRIPT'
cat <<EOF >> /etc/hosts
$1  $2
EOF
SCRIPT

Vagrant.configure("2") do |config|
  machines.each do |name, conf|
    config.vm.define "#{name}" do |my|
      my.vm.box = "#{conf["image"]}"
      my.vm.hostname = "#{name}.test"
      my.vm.network "private_network", ip: "#{ipNet}#{conf["ipHost"]}"
      my.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}_#{ipNet}#{conf["ipHost"]}"
        vb.memory = "#{conf["memory"]}"
        vb.cpus = "#{conf["cpus"]}"
      end
    if "#{name}" == "ans-rd"
      # my.vm.provision "shell", inline: 
      my.vm.provision "shell", path: "installAnsRd.sh"
      machines.each do |name, conf|
        my.vm.provision "shell", inline: $createInventory, args: ["#{name}", "#{name}"]
        my.vm.provision "shell", inline: $createHosts, args: ["#{ipNet}#{conf["ipHost"]}", "#{name}.test"]
      end
    end
    end
  end
end
