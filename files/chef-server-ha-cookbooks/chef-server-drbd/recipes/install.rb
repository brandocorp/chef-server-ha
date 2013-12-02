if platform_family?('rhel')
  packages = [ "drbd84-utils", "kmod-drbd84" ]
elsif platform_family('debian')
  packages = [ "drbd8-utils" ]
end

remote_file "#{Chef::Config[:file_cache_path]}/elrepo.noarch.rpm" do
  owner "root"
  group "root"
  mode "0644"
  source "http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm"
end

package "Enterprise Linux Repo" do
  source "#{Chef::Config[:file_cache_path]}/elrepo.noarch.rpm"
  action :install
  not_if { "rpm -qa | grep 'elrepo-release'" }
end

packages.each do |pkg|
  package pkg do
    action :install
    not_if { "rpm -qa | grep #{pkg}" }
  end
end

service "drbd" do
  supports( :restart => true, :status => true )
  action :nothing
end
