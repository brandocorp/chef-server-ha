include_recipe "chef-server-drbd::drbd"
include_recipe "chef-server-keepalived::default"

resource = node.set['chef-server']['drbd']['resource_name'] = "chef-server"

primary = node['chef_server']['servers'].select {|s| s['role'] == 'primary' }.first
secondary = node['chef_server']['servers'].select {|s| s['role'] == 'secondary' }.first

if primary[:fqdn] =~ /#{node[:fqdn]}/
  node.set['chef_server']['drbd']['master'] = true
end

template "/etc/drbd.d/global_config.conf" do
  source "global_config.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/drbd.d/#{resource}.res" do
  source "#{resource}.res.erb"
  variables({
    :resource => resource,
    :device => node['chef_server']['drbd']['device'],
    :disk => node['chef_server']['drbd']['disk'],
    :port => node['chef_server']['drbd']['port'],
    :primary => primary,
    :secondary => secondary
  })
  owner "root"
  group "root"
  action :create
end

#first pass only, initialize drbd
execute "drbdadm create-md #{resource}" do
  subscribes :run, "template[/etc/drbd.d/#{resource}.res]"
  notifies :restart, "service[drbd]", :immediately
  only_if do
    shell = Mixlib::ShellOut.new("drbd-overview")
    shell.run_command
    Chef::Log.info shell.stdout
    shell.stdout.include?("drbd not loaded")
  end
  action :nothing
end

#claim primary based off of node['chef_server']['drbd']['master']
execute "drbdadm primary --force #{resource}" do
  subscribes :run, "execute[drbdadm create-md #{resource}]"
  only_if { node['chef_server']['drbd']['master'] && !node['chef_server']['drbd']['configured'] }
  action :nothing
end

#You may now create a filesystem on the device, use it as a raw block device
execute "mkfs -t #{node['chef_server']['drbd']['fs_type']} #{node['chef_server']['drbd']['device']}" do
  subscribes :run, "execute[drbdadm primary --force #{resource}]"
  only_if { node['chef_server']['drbd']['master'] && !node['chef_server']['drbd']['configured'] }
  action :nothing
end

directory node['chef_server']['drbd']['dir'] do
  only_if { node['chef_server']['drbd']['master'] && !node['chef_server']['drbd']['configured'] }
  action :create
end

#mount -t xfs -o rw /dev/drbd0 /shared
mount node['chef_server']['drbd']['dir'] do
  device node['chef_server']['drbd']['device']
  fstype node['chef_server']['drbd']['fs_type']
  only_if { node['chef_server']['drbd']['master'] && node['chef_server']['drbd']['configured'] }
  action :mount
end

#hack to get around the mount failing
ruby_block "set drbd configured flag" do
  block do
    node.set['drbd']['configured'] = true
  end
  subscribes :create, "execute[mkfs -t #{node['chef_server']['drbd']['fs_type']} #{node['chef_server']['drbd']['dev']}]"
  action :nothing
end

include_recipe "chef-server-keepalived::configure"
