module Labmapper
  class Host

    attr_accessor :name, :user, :nossh, :uptime
    @@suffix = '.cs.ucsb.edu' # TODO grab from labrc
    @@invalid_users = ['(unknown)', 'root'] # TODO fix
    # build out ssh options
    @@options = '-o ConnectTimeout=5 ' # in seconds
    @@options += '-o UserKnownHostsFile=/dev/null '
    # doesn't check RSA fingerprint
    @@options += '-o StrictHostKeyChecking=no '

    def initialize(name, key='~/.ssh/id_rsa.pub')
      @name = name
      @nossh = false
      @user = @uptime = nil
      @key = key
    end

    # TODO improve this -- place ssh keys before polling
    def send_key
      res = `ssh-copy-id #{@@options}-i #{@key} #{@name}#{@@suffix}`
      puts "Could not send key to #{@name}" unless $?.success?
    end

    def poll
      res = ssh(['uptime', 'who'])
      if res.nil?
        @nossh = true
      else
        @uptime, *whos = res.split("\n")
        whos.each do |who|
          user, tty, date, time, ip = who.split
          if ip.nil? || ip.size < 6 # TODO no magic number please
            @user = user unless @@invalid_users.index(user)
          end
        end
      end
      debug # TODO if $DEBUG ?
    end

    def debug
      # TODO let's use log4r
      puts "#{@name}: #{@user}"
    end

    def to_json(*a)
      {name: @name, nossh: @nossh, user: @user}.to_json(*a)
    end

    private

    def ssh(cmds=['who'])
      out = `ssh -q #{@@options}#{@name}#{@@suffix} '#{cmds.join(' ; ')}'`
      # if ssh returned with non-0 exit status
      $?.success? ? out : nil
    end

  end
end
