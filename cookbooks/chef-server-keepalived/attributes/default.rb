####
# Keepalived
####
default['chef_server']['keepalived']['enable'] = false
default['chef_server']['keepalived']['dir'] = "/var/opt/chef-server/keepalived"
default['chef_server']['keepalived']['log_directory'] = "/var/log/chef-server/keepalived"
default['chef_server']['keepalived']['svlogd_size'] = 1000000
default['chef_server']['keepalived']['svlogd_num'] = 10
default['chef_server']['keepalived']['smtp_connect_timeout'] = "30"
default['chef_server']['keepalived']['smtp_server'] = nil
default['chef_server']['keepalived']['notification_email'] = []
default['chef_server']['keepalived']['notification_email_from'] = nil
default['chef_server']['keepalived']['vrrp_instance_advert_int'] = "1"
default['chef_server']['keepalived']['vrrp_instance_interface'] = "eth0"
default['chef_server']['keepalived']['vrrp_instance_ipaddress'] = nil
default['chef_server']['keepalived']['vrrp_instance_ipaddress_dev'] = "eth0"
default['chef_server']['keepalived']['vrrp_instance_password'] = nil
default['chef_server']['keepalived']['vrrp_instance_priority'] = "100"
default['chef_server']['keepalived']['vrrp_instance_state'] = "MASTER"
default['chef_server']['keepalived']['vrrp_instance_virtual_router_id'] = "1"
default['chef_server']['keepalived']['service_order'] = [
  "postgresql",
  "rabbitmq",
  "chef-solr",
  "chef-expander",
  "erchef",
  "bookshelf",
  "chef-server-webui",
  "nginx"
]
