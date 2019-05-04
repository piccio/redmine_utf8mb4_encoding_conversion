namespace :utf8mb4_encoding do
  desc 'set rails db encoding to utf8mb4'
  task set_rails_db_encoding: [:environment] do
    puts 'BEGIN set rails db encoding to utf8mb4'

    require 'yaml'

    file_path = "#{Rails.root}/config/database.yml"
    db = YAML.load(File.read(file_path))

    db.each_key do |key|
      db[key]['encoding'] = 'utf8mb4'
      db[key]['collation'] = 'utf8mb4_unicode_ci'
    end

    File.open(file_path, "w") { |file| file.write(db.to_yaml) }

    puts 'END set rails db encoding to utf8mb4'
    puts ''
  end
end