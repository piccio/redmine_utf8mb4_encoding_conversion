namespace :utf8mb4_encoding do
  # https://www.percona.com/doc/percona-toolkit/LATEST/pt-online-schema-change.html
  desc 'install pt-online-schema-change tool'
  task :install_pt_online_schema_change, [:hostname, :sudoer_user] => [:environment] do |task, args|
    puts 'BEGIN install pt-online-schema-change tool'

    args.with_defaults(hostname: 'localhost')

    if args.sudoer_user.nil?
      sh('sudo apt-get install -f percona-toolkit')
    else
      sh("ssh -t #{args.sudoer_user}@#{args.hostname} 'sudo apt-get install -f percona-toolkit'")
    end

    puts 'END install pt-online-schema-change tool'
    puts ''
  end
end