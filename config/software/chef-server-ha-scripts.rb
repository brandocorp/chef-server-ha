name "chef-server-ha-scripts"

dependency "rsync"

source :path => File.expand_path("files/chef-server-ha-scripts", Omnibus.project_root)

build do
  command "mkdir -p #{install_dir}/bin"
  command "#{install_dir}/embedded/bin/rsync --delete -a ./ #{install_dir}/bin/"
  command "chmod 755 #{install_dir}/bin/*"
end
