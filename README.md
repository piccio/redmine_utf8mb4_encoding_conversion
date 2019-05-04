redmine_utf8mb4_encoding_conversion
=

tested on redmine 3.4.4 and mysql 5.7.25

```bash
$ rake -T utf8mb4_encoding:
rake utf8mb4_encoding:columns_conversion[hostname,sudoer_user,db_user,db_pwd]                # convert the columns to the utf8mb4 character set
rake utf8mb4_encoding:conversion[hostname,sudoer_user,db_user,db_pwd]                        # utf8mb4 encoding conversion (run all the necessary steps)
rake utf8mb4_encoding:install_pt_online_schema_change[hostname,sudoer_user]                  # install pt-online-schema-change tool
rake utf8mb4_encoding:restart_mysql[hostname,sudoer_user]                                    # restart mysql service
rake utf8mb4_encoding:set_configuration[hostname,sudoer_user]                                # set configuration options: 'Barracuda' file format, utf8mb4 character set, etc..
rake utf8mb4_encoding:set_db_default_character_set[db_user,db_pwd]                           # set db default character set to utf8mb4
rake utf8mb4_encoding:set_rails_db_encoding                                                  # set rails db encoding to utf8mb4
rake utf8mb4_encoding:solving_767_byte_index_key_limit[hostname,sudoer_user,db_user,db_pwd]  # solving the 767 byte index key limit
rake utf8mb4_encoding:tables_conversion[hostname,sudoer_user,db_user,db_pwd]                 # convert the tables to the 'Barracuda' file format and set the character set to utf8mb4
```