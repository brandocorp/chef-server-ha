####
# DRBD
####
default['chef_server']['drbd']['enable'] = false
default['chef_server']['drbd']['disk'] = "/dev/drbd/by-res/chef-server"
default['chef_server']['drbd']['dir'] = "/var/opt/chef-server"
default['chef_server']['drbd']['log_directory'] = "/var/log/chef-server/drbd"
default['chef_server']['drbd']['fs_type'] = "ext4"
default['chef_server']['drbd']['device'] = "/dev/drbd0"
default['chef_server']['drbd']['master'] = false
default['chef_server']['drbd']['port'] = 7789
default['chef_server']['drbd']['configured'] = false
