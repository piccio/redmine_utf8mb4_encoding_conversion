namespace :utf8mb4_encoding do
  desc 'solving the 767 byte index key limit'
  task :solving_767_byte_index_key_limit, [:hostname, :sudoer_user, :db_user, :db_pwd] => [:environment] do |task, args|
    puts 'BEGIN solving the 767 byte index key limit'

    Rake::Task['utf8mb4_encoding:set_configuration'].invoke(args.hostname, args.sudoer_user)
    Rake::Task['utf8mb4_encoding:set_db_default_character_set'].invoke(args.db_user, args.db_pwd)
    Rake::Task['utf8mb4_encoding:tables_conversion'].invoke(args.hostname, args.sudoer_user, args.db_user, args.db_pwd)
    Rake::Task['utf8mb4_encoding:columns_conversion'].invoke(args.hostname, args.sudoer_user, args.db_user, args.db_pwd)

    puts 'END solving the 767 byte index key limit'
    puts ''
  end
end
