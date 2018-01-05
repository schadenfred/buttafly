$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "buttafly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "buttafly"
  s.version     = Buttafly::VERSION
  s.authors     = ["Frederick D. Schoeneman"]
  s.email       = ["fred.schoeneman@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Buttafly."
  s.description = "TODO: Description of Buttafly."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
