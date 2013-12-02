config_dir = "#{node['chef_server']['keepalived']['dir']}/etc"

directory "#{config_dir}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

template "#{config_dir}/keepalived.conf" do
  source "keepalived.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['chef_server']['keepalived'],
  })
end

[ "check", "active", "passive", "failure" ].each do |state|
  template node['chef_server']['keepalived']["#{state}_script"] do
    source "#{state}.erb"
    owner "root"
    group "root"
    mode "0755"
    variables({
      :drbd_resource => node['chef_server']['drbd']['resource_name']
    })
  end
end

runit_service "keepalived" do
  options({
    :log_directory => node['chef_server']['keepalived']['log_directory']
  }.merge(params))
end
