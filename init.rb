# https://www.redmine.org/issues/21398
# https://railsmachine.com/articles/2017/05/19/converting-a-rails-database-to-utf8mb4.html
Redmine::Plugin.register :redmine_utf8mb4_encoding_conversion do
  name 'Redmine Encoding Conversion plugin'
  author 'Roberto Piccini'
  description 'encoding conversion of the mysql db to utf8mb4'
  version '1.0.1'
  url 'https://github.com/piccio/redmine_utf8mb4_encoding_conversion'
  author_url 'https://github.com/piccio'
end
