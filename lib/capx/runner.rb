module Capx
  class Runner
    PATTERN = /server:?\s+[\'\"]([\w\-\.]+)[\'\"],\s+user:?\s+[\'\"]([\w\-\.]+)[\'\"]/

    def initialize(options)
      @stage  = options[:stage]
      @switch = options[:switch]
      @user   = options[:user]
      @server = nil
    end

    def run
      file = "config/deploy/#{@stage}.rb"
      if File.exist?(file)
        File.open(file).each do |line|
          if match = PATTERN.match(line)
            @server = match.captures[0]
            @user = match.captures[1] if @user.nil?
          end
        end

        if @server.nil? || @user.nil?
          puts 'capistrano server/user not found'
        else
          ssh_cmd = "ssh #{@user}@#{@server}"
          if @switch == 'ssh'
            # call ssh
            cmd = ssh_cmd
            execute_cmd(cmd)
          elsif @switch == 'disk'
            # call remote df -H
            cmd = "#{ssh_cmd} 'df -H'"
            execute_cmd(cmd)
          elsif @switch == 'info'
            # call remote cat /etc/*-release
            cmd = "#{ssh_cmd} 'cat /etc/*-release'"
            execute_cmd(cmd)
          elsif @switch == 'redis'
            # call remote redis-cli INFO keyspace
            cmd = "#{ssh_cmd} 'redis-cli INFO keyspace'"
            execute_cmd(cmd)
          else
            puts "#{@user}@#{@server}"
          end
        end
      else
        puts "File #{file} not found"
      end
    end

    private

    def execute_cmd(cmd)
      puts "executing #{cmd}"
      exec(cmd)
    end
  end
end
