# -*- encoding: utf-8 -*-
# stub: capistrano-unicorn-nginx 5.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-unicorn-nginx".freeze
  s.version = "5.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ruben Stranders".freeze, "Bruno Sutic".freeze]
  s.date = "2018-06-05"
  s.description = "Capistrano tasks for automatic  and sensible unicorn + nginx configuraion.\nEnables zero downtime deployments of Rails applications. Configs can be\ncopied to the application using generators and easily customized.\nWorks *only* with Capistrano 3+. For Capistrano 2 try version 0.0.8 of this\ngem: http://rubygems.org/gems/capistrano-nginx-unicorn\n".freeze
  s.email = ["r.stranders@gmail.com".freeze, "bruno.sutic@gmail.com".freeze]
  s.files = [".gitignore".freeze, "CHANGELOG.md".freeze, "Gemfile".freeze, "LICENSE.md".freeze, "README.md".freeze, "Rakefile".freeze, "capistrano-unicorn-nginx.gemspec".freeze, "lib/capistrano-unicorn-nginx.rb".freeze, "lib/capistrano/dsl/nginx_paths.rb".freeze, "lib/capistrano/dsl/unicorn_paths.rb".freeze, "lib/capistrano/tasks/nginx.rake".freeze, "lib/capistrano/tasks/unicorn.rake".freeze, "lib/capistrano/unicorn_nginx.rb".freeze, "lib/capistrano/unicorn_nginx/helpers.rb".freeze, "lib/capistrano/unicorn_nginx/version.rb".freeze, "lib/generators/capistrano/unicorn_nginx/USAGE.md".freeze, "lib/generators/capistrano/unicorn_nginx/config_generator.rb".freeze, "lib/generators/capistrano/unicorn_nginx/templates/_default_server_directive.erb".freeze, "lib/generators/capistrano/unicorn_nginx/templates/nginx_conf.erb".freeze, "lib/generators/capistrano/unicorn_nginx/templates/unicorn-logrotate.rb.erb".freeze, "lib/generators/capistrano/unicorn_nginx/templates/unicorn.rb.erb".freeze, "lib/generators/capistrano/unicorn_nginx/templates/unicorn_init.erb".freeze]
  s.homepage = "https://github.com/bruno-/capistrano-unicorn-nginx".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Capistrano tasks for automatic and sensible unicorn + nginx configuraion.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<sshkit>.freeze, [">= 1.2.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<capistrano>.freeze, [">= 3.1"])
      s.add_dependency(%q<sshkit>.freeze, [">= 1.2.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>.freeze, [">= 3.1"])
    s.add_dependency(%q<sshkit>.freeze, [">= 1.2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
