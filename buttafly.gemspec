$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "buttafly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "buttafly"
  s.version     = Buttafly::VERSION
  s.authors     = ["Frederick D. Schoeneman"]
  s.email       = ["fred.schoeneman@gmail.com"]
  s.homepage    = "https://github.com/schadenfred/buttafly"
  s.summary     = "Map spreadsheet data into your app."
  s.description = "Upload a spreadsheet, map its headers to your columns, and create database objects with the correct associations."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "haml-rails"
  s.add_dependency "aasm"
  s.add_dependency "carrierwave"
  s.add_dependency "kaminari"
  

  # development & testing
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "puma"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-rails-capybara"
  s.add_development_dependency "minitest-given"
  s.add_development_dependency "minitest-nyan-cat"
  s.add_development_dependency "launchy"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-minitest"
  s.add_development_dependency "guard-livereload"
  s.add_development_dependency "rack-livereload"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "byebug"
  s.add_development_dependency "better_errors"
  s.add_development_dependency "binding_of_caller"
end
