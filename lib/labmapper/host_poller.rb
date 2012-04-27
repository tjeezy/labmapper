module Labmapper
  class HostPoller

    # TODO add option (in Config?) to specify
    # path to ssh key for Host#send_key

    @@hostnames = Labmapper::Config.hosts

    @@hosts = []
    @@hostnames.each do |hostname|
      @@hosts << Host.new(hostname)
    end

    def self.poll(opts={})
      Parallel.map(@@hosts, opts) do |host|
        host.poll
      end
    end

    def self.serialize(file)
      File.open(file, 'w') do |f|
        output = {timestamp: DateTime.now, hosts: {}}
        @@hosts.each do |host|
          output[:hosts][host.name] = {
            user: host.user,
            nossh: host.nossh,
            uptime: host.uptime
          }
        end
        f.puts output.to_json
      end
    end

  end
end
