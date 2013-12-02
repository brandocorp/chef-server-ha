name "drbd"
version "8.4.4"

source :url => "http://oss.linbit.com/drbd/8.4/drbd-8.4.4.tar.gz",
       :md5 => "ffa3585fb16118bb6d13dc5636980464"

relative_path "drbd-8.4.4"

build do
  command [
    "./configure",
    "--prefix=#{install_dir}/embedded",
    "--bindir=#{install_dir}/embedded/bin",
    "--sbindir=#{install_dir}/embedded/bin",
    "--libdir=#{install_dir}/embedded/lib",
    "--includedir=#{install_dir}/embedded/include",
    "--localstatedir=/var#{install_dir}/drbd",
    "--sysconfdir=/var#{install_dir}/etc",
    "--with-bashcompletion"
  ]
  command "make -j #{max_build_jobs}", :env => {
    "LDFLAGS" => "#{install_dir}/embedded/lib",
    "KDIR" => "#{install_dir}/embedded/lib/modules"
  }
  command "make install"
end
