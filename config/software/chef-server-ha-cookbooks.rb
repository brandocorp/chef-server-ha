name "chef-server-ha-cookbooks"

dependency "rsync"

source :path => File.expand_path("files/chef-server-ha-cookbooks", Omnibus.project_root)

build do
  command "mkdir -p #{install_dir}/embedded/cookbooks"
  command "#{install_dir}/embedded/bin/rsync --delete -a ./ #{install_dir}/embedded/cookbooks/"
end
