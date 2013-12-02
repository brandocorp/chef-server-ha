config_dir = "#{node['chef_server']['keepalived']['dir']}/etc"
bin_dir = "#{node['chef_server']['keepalived']['dir']}/bin"

[ config_dir, bin_dir ].each do |dir|
  directory dir do
    owner "root"
    group "root"
    mode "0755"
    action :create
    recursive true
  end
end

[ "check", "active", "passive", "failure" ].each do |state|
  node.set['chef_server']['keepalived']["#{state}_script"] = "#{bin_dir}/#{state}"
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

template "#{config_dir}/keepalived.conf" do
  source "keepalived.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :config => node['chef_server']['keepalived'],
  })
end
