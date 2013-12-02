require 'mixlib/config'
require 'chef/mash'

module ChefTopology
  extend(Mixlib::Config)

  drbd Mash.new
  keepalived Mash.new
  lvm Mash.new
  topology nil
  servers Array.new

  class << self

    # Topology: failover
    def primary(fqdn, info)
      ChefTopology['servers'] << info.merge({'fqdn' => fqdn, 'role' => 'primary'})
    end

    def secondary(fqdn, info)
      ChefTopology['servers'] << info.merge({'fqdn' => fqdn, 'role' => 'secondary'})
    end

    # Topology: tier/ha
    def frontend(fqdn, info)
      ChefTopology['servers'] << info.merge({'fqdn' => fqdn, 'role' => 'frontend'})
    end

    def backend(fqdn, info, role=backend)
      ChefTopology['servers'] << info.merge({'fqdn' => fqdn, 'role' => role})
    end

    def generate_config
      config = { 'chef_server' => {} }
      ChefTopology.keys.each do |key|
        config['chef_server']["#{key}"] = ChefTopology[key]
      end
      config
    end

  end
end
