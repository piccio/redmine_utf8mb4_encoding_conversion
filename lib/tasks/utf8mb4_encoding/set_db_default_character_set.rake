namespace :utf8mb4_encoding do
  desc "set db default character set to utf8mb4"
  task :set_db_default_character_set, [:db_user, :db_pwd] => [:environment] do |task, args|
    puts 'BEGIN set db default character set to utf8mb4'

    db = ActiveRecord::Base.connection
    db_config = ActiveRecord::Base.connection_config
    args.with_defaults(db_user: db_config[:username], db_pwd: db_config[:password])

    mysql_cmd = "ALTER DATABASE #{db.current_database} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
    sh("mysql -u #{args.db_user} -p#{args.db_pwd} -e '#{mysql_cmd}'")

    puts 'END set db default character set to utf8mb4'
    puts ''
  end
end