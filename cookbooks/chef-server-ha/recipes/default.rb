include_recipe "runit"

if File.exists?('/etc/chef-server/chef-topology.rb')
  ChefTopology.from_file('/etc/chef-server/chef-topology.rb')
end

node.consume_attributes(ChefTopology.generate_config)

if node['chef_server']['lvm']['enable']
  include_recipe "chef-server-lvm::configure"
end

if node['chef_server']['drbd']['enable']
  include_recipe "chef-server-drbd::configure"
end

if node['chef_server']['keepalived']['enable']
  include_recipe "chef-server-keepalived::configure"
end
