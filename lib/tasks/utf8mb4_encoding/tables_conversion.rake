namespace :utf8mb4_encoding do
  # db user must have process privileges
  # https://www.percona.com/doc/percona-toolkit/LATEST/pt-online-schema-change.html#system-requirements
  desc "convert the tables to the 'Barracuda' file format and set the character set to utf8mb4"
  task :tables_conversion,
       [:hostname, :sudoer_user, :db_user, :db_pwd] => [:environment, :install_pt_online_schema_change] do |task, args|
    puts "BEGIN: convert the tables to the 'Barracuda' file format and set the character set to utf8mb4"

    db = ActiveRecord::Base.connection
    db_config = ActiveRecord::Base.connection_config
    args.with_defaults(db_user: db_config[:username], db_pwd: db_config[:password])
    # command = 'dry-run'
    command = 'execute'

    db.tables.each do |table|
      puts "# #{table}"

      mysql_alter = 'ROW_FORMAT=DYNAMIC CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci'

      sh("pt-online-schema-change --user=#{args.db_user} --password=#{args.db_pwd} --alter '#{mysql_alter}' D=#{db.current_database},t=#{table} --chunk-size=10k --critical-load Threads_running=200 --set-vars innodb_lock_wait_timeout=2 --alter-foreign-keys-method=auto --#{command}") do |ok, res|
        # primary key fix
        # The new table `redmine_staging`.`_<originale_table_name>_new` does not have a PRIMARY KEY or a unique index which is required for the DELETE trigger.
        # rake aborted!
        # Command failed with status (29): [...]
        # triggers fix
        # The table `redmine_staging`.`<table>` has triggers.  This tool needs to create its own triggers, so the table cannot already have triggers.
        # rake aborted!
        # Command failed with status (255): [...]
        if !ok && (res.exitstatus == 29 || res.exitstatus == 255)
          puts 'WARNING: this conversion will require a full table copy and will lock the table for the duration of the copy'
          sh("mysql -u #{args.db_user} -p#{args.db_pwd} -D #{db.current_database} -e 'ALTER TABLE #{table} #{mysql_alter}'")
        end
      end

      puts ''
    end

    puts "END: convert the tables to the 'Barracuda' file format and set the character set to utf8mb4"
    puts ''
  end
end