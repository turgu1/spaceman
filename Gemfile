source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                        '~> 5.2.2.1' # was 5.2.0 (GT)
gem 'pg',                           '~> 1.0.0'
gem 'puma',                         '~> 3.12'
gem 'sass-rails',                   '~> 5.0'
gem 'uglifier',                     '>= 4.1.8'
# gem 'therubyracer', platforms: :ruby

gem 'coffee-rails',                 '~> 4.2'
#gem 'turbolinks',                  '~> 5'
gem 'jbuilder',                     '~> 2.5'

gem 'activemodel-serializers-xml',  '~> 1.0.2'
gem 'jquery-rails',                 '~> 4.3.1'
gem 'jquery-ui-rails',              '~> 6.0.1'

gem 'haml-rails',                   '~> 1.0.0'

gem 'simple_form',                  '~> 5.0.0'
gem 'cocoon',                       '~> 1.2.11'

gem 'devise',                       '~> 4.7.1' # was 4.6.1 (GT)
gem 'cancancan',                    '~> 2.1.3'

gem 'carrierwave',                  '~> 1.2.2'
gem 'rmagick',                      '~> 2.16.0'

gem 'bootstrap-sass',               '~> 3.4.1' # was 3.3.7 (GT)
gem 'bootstrap-datepicker-rails',   '~> 1.8.0.1'
gem 'font-awesome-rails',           '~> 4.7.0'

gem 'rouge',                        '~> 3.1.1'
gem 'historyjs-rails',              '~> 1.0.1'

gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails',                  '~> 0.5.2'

gem 'ace-rails-ap',                 '~> 4.1.4'
gem 'yaml_db', github: 'turgu1/yaml_db', branch: 'rails4'

gem 'rubyzip',                      '~> 1.3.0'

gem 'unicorn',                      '~> 5.4.0'

#gem 'loofah',                       '~> 2.2.1'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development do
  gem 'web-console',                '>= 3.5.1'
end

group :development, :test do
  gem 'byebug',                     '~> 10.0.2'
  gem 'listen',                     '>= 3.1.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',      '~> 2.0.0'
  gem 'capistrano',                 '~> 3.10',  require: false
  gem 'capistrano-bundler',         '~> 1.3',   require: false
  gem 'capistrano-rails',           '~> 1.3.1', require: false
  gem 'capistrano-rbenv',           '~> 2.1',   require: false
  gem 'capistrano-safe-deploy-to',  '~> 1.1.1', require: false
  gem 'capistrano-ssh-doctor',      '~> 1.0',   require: false
  gem 'capistrano-secrets-yml',     '~> 1.1.0', require: false
  gem 'sshkit-sudo'
  gem 'capistrano-unicorn-nginx',   '~> 5.2.0', require: false
  gem 'capistrano-postgresql',      '~> 5.0.1', require: false
  gem 'rspec-rails',                '~> 3.7.2'
  gem 'poltergeist',                '~> 1.17.0'
  gem 'database_cleaner',           '~> 1.6.2'
  gem 'factory_bot_rails',          '~> 4.8.2', require: false
  #gem 'bullet',                    '~> 5.6.0'
  gem 'i18n-tasks',                 '~> 0.9.21'

  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end
