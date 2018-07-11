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
          puts "capistrano server/user not found"
        else
          if @switch == 'ssh'
            # call ssh  
            cmd = "ssh #{@user}@#{@server}"
            execute_cmd(cmd)
          elsif @switch == 'disk'
            # call remote df -H
            cmd = "ssh #{@user}@#{@server} 'df -H'" 
            execute_cmd(cmd)
          elsif @switch == 'info'
            cmd = "ssh #{@user}@#{@server} 'cat /etc/*-release'"  
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