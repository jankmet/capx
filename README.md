# CapX

Generates SSH commands using capistrano deploy configuration. \
SSH username and host are parsed from capistrano deploy configuration. \
\
capistrano deploy configuration:

    server 'dev.example.com', user: 'deploy', roles: %w{web app db}, primary: true
generated SSH command:

    $ ssh deploy@dev.example.com

## Installation


    $ gem install capx


## Usage



This will add the following executable in your shell:


capx [stage] [ssh|disk|info] [user]


### Examples:

    $ capx staging  # show ssh command
    $ capx production ssh  # execute ssh command
    $ capx production ssh root # execute ssh command with root user
    $ capx production disk # execute ssh 'df -H' command