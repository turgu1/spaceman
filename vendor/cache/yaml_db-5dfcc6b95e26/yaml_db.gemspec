# -*- encoding: utf-8 -*-
# stub: yaml_db 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "yaml_db".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Wiggins".freeze, "Orion Henry".freeze]
  s.date = "2012-04-30"
  s.description = "\nYamlDb is a database-independent format for dumping and restoring data.  It complements the the database-independent schema format found in db/schema.rb.  The data is saved into db/data.yml.\nThis can be used as a replacement for mysqldump or pg_dump, but only for the databases typically used by Rails apps.  Users, permissions, schemas, triggers, and other advanced database features are not supported - by design.\nAny database that has an ActiveRecord adapter should work\n".freeze
  s.email = "nate@ludicast.com".freeze
  s.extra_rdoc_files = ["README.markdown".freeze]
  s.files = [".travis.yml".freeze, "README.markdown".freeze, "Rakefile".freeze, "VERSION".freeze, "about.yml".freeze, "init.rb".freeze, "lib/csv_db.rb".freeze, "lib/serialization_helper.rb".freeze, "lib/tasks/yaml_db_tasks.rake".freeze, "lib/yaml_db.rb".freeze, "spec/base.rb".freeze, "spec/serialization_helper_base_spec.rb".freeze, "spec/serialization_helper_dump_spec.rb".freeze, "spec/serialization_helper_load_spec.rb".freeze, "spec/serialization_utils_spec.rb".freeze, "spec/yaml_dump_spec.rb".freeze, "spec/yaml_load_spec.rb".freeze, "spec/yaml_utils_spec.rb".freeze, "yaml_db.gemspec".freeze]
  s.homepage = "http://github.com/ludicast/yaml_db".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "yaml_db allows export/import of database into/from yaml files".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version
end
