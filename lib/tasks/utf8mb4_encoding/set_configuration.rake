namespace :utf8mb4_encoding do
  desc "set configuration options: 'Barracuda' file format, utf8mb4 character set, etc..."
  task :set_configuration, [:hostname, :sudoer_user] => [:environment] do |task, args|
    puts "BEGIN set configuration options: 'Barracuda' file format, utf8mb4 character set, etc..."

    args.with_defaults(hostname: 'localhost')
    src = "#{Rails.root}/plugins/redmine_utf8mb4_encoding_conversion/lib/files/utf8mb4.cnf"
    dst = '/etc/mysql/mysql.conf.d/90_utf8mb4.cnf'

    if args.sudoer_user.nil?
      sh("sudo cp #{src} #{dst}")
    else
      # a little bit tricky but the only way if current user is not a sudoer user
      sh("ssh -t #{args.sudoer_user}@#{args.hostname} 'sudo cp #{src} #{dst}'")
    end

    puts "END set configuration options: 'Barracuda' file format, utf8mb4 character set, etc..."
    puts ''
  end
end