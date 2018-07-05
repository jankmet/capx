module Capx
  class Runner
    PATTERN = /server:?\s+[\'\"]([\w\-\.]+)[\'\"],\s+user:?\s+[\'\"]([\w\-\.]+)[\'\"]/

    def initialize(options)
      @stage  = options[:stage]
      @switch = options[:switch]
      @server = nil
      @user   = nil
    end

    def run
      file = "config/deploy/#{@stage}.rb"
      if File.exist?(file)
        File.open(file).each do |line|
          if match = PATTERN.match(line)
            @server = match.captures[0]
            @user = match.captures[1]
          end  
        end

        if @server.nil? || @user.nil?
          puts "capistrano server/user not found"
        else
          if ARGV[1] == 'ssh'
            # call ssh  
            cmd = "ssh #{@user}@#{@server}"
            puts "executing #{cmd}"
            exec(cmd)
          else    
            puts "#{@user}@#{@server}"
          end 
        end
      else
        puts "File #{file} doesnt exist"  
      end  
    end
  end
end