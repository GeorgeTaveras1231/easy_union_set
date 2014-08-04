$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "easy_union_set/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "easy_union_set"
  s.version     = EasyUnionSet::VERSION
  s.authors     = ["George Taveras"]
  s.email       = ["george.taveras1231@gmail.com"]
  s.homepage    = "https://github.com/GeorgeTaveras1231/easy_union_set"
  s.summary     = "Easily create sql UNIONS and INTERSECTS in ActiveRecord"
  s.description = "A lightweight gem that provides two AR:Relation methods to create unions and sets #& and #|"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activerecord"

  s.add_development_dependency "rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "faker"
end
