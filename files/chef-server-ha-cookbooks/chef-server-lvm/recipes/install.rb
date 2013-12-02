package 'lvm2' do
  action :nothing
  not_if "rpm -qa | grep lvm2"
end.run_action(:install)
