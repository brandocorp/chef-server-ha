####
# LVM
####

default['chef_server']['lvm']['volume_group'] = 'chef-server'
default['chef_server']['lvm']['logical_volume'] = 'drbd'
default['chef_server']['lvm']['devices'] = []
