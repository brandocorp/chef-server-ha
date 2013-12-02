maintainer        "BrandoCorp"
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures Chef Server from Omnibus"
long_description       "Installs and configures Chef Server from Omnibus"
version           "0.1.0"
recipe            "chef-server-ha", "Configures the Chef Server HA components"

%w{ ubuntu debian redhat centos }.each do |os|
  supports os
end

depends "chef-server-lvm"
depends "chef-server-drbd"
depends "chef-server-keepalived"
