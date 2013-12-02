lvm_volume_group = node['chef_server']['lvm']['volume_group']
lvm_logical_volume = node['chef_server']['lvm']['logical_volume']
lvm_devices = node['chef_server']['lvm']['devices']

lvm_devices.each do |device|
  execute "pvcreate #{device}" do
    action :run
  end
end

execute "vgcreate #{lvm_volume_group} #{lvm_devices.join(' ')}" do
  action :run
end

execute "lvcreate -l 100%FREE --name #{lvm_logical_volume} #{lvm_volume_group}" do
  action :run
end
