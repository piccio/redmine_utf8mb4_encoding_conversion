namespace :utf8mb4_encoding do
  desc "restart mysql service"
  task :restart_mysql, [:hostname, :sudoer_user] => [:environment] do |task, args|
    puts 'BEGIN restart mysql service'

    args.with_defaults(hostname: 'localhost')

    if args.sudoer_user.nil?
      sh('sudo systemctl restart mysql.service')
    else
      # a little bit tricky but the only way if current user is not a sudoer user
      sh("ssh -t #{args.sudoer_user}@#{args.hostname} 'sudo systemctl restart mysql.service'")
    end

    puts 'END restart mysql service'
    puts ''
  end
end