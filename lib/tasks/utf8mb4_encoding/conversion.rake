namespace :utf8mb4_encoding do
  # https://railsmachine.com/articles/2017/05/19/converting-a-rails-database-to-utf8mb4.html
  desc 'utf8mb4 encoding conversion (run all the necessary steps)'
  task :conversion, [:hostname, :sudoer_user, :db_user, :db_pwd] => [:environment] do |task, args|
    puts 'BEGIN utf8mb4 encoding conversion'

    Rake::Task['utf8mb4_encoding:solving_767_byte_index_key_limit'].
      invoke(args.hostname, args.sudoer_user, args.db_user, args.db_pwd)
    Rake::Task['utf8mb4_encoding:restart_mysql'].invoke(args.hostname, args.sudoer_user)
    Rake::Task['utf8mb4_encoding:set_rails_db_encoding'].invoke

    puts 'END utf8mb4 encoding conversion'
    puts ''
  end
end