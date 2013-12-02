name "chef-server-ha"
maintainer "BrandoCorp"
homepage "http://brandocorp.github.io/chef-server-ha/"

replaces        "chef-server-ha"
install_path    "/opt/chef-server-ha"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# global
dependency "openssl"

# failover
dependency "keepalived"

# DRBD is currently being handled by package installs.
# I'd like to incorporate this into the rpm eventually.
#
# data redudnancy
#dependency "drbd"

# the HA internals and config
dependency "chef-server-ha-cookbooks"
dependency "chef-server-ha-scripts"

exclude "\.git*"
exclude "bundler\/git"
