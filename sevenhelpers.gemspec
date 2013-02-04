$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sevenhelpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sevenhelpers"
  s.version     = Sevenhelpers::VERSION
  s.authors     = ["Steve Clarke"]
  s.email       = ["steve@sevenview.ca"]
  s.homepage    = "https://github.com/Sevenview/sevenhelpers"
  s.summary     = "Common stuff that we use on all Rails apps we work on."
  s.description = "Common stuff that we use on all Rails apps we work on."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
