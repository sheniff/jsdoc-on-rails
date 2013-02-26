$:.push File.expand_path("../lib", __FILE__)
require "jsdoc-on-rails/version"

Gem::Specification.new do |s|
  s.name = "jsdoc-on-rails"

  s.authors     = ["Sheniff"]
  s.email       = ["sheniff@gmail.com"]
  s.homepage    = "https://github.com/sheniff/jsdoc-on-rails"

  s.version     = JsdocOnRails::VERSION

  s.summary     = "Rails 3.1 JSDoc documentation generator"
  s.description = "Doesn't require Java to parse your JavaScript documentation and load it into your site's database."

  s.files       = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files  = Dir["test/**/*"]

  s.add_dependency('rails', '>= 3.1.0.rc5')
end
