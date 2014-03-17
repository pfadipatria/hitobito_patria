$:.push File.expand_path("../lib", __FILE__)

# Maintain your wagon's version:
require "hitobito_patria/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hitobito_patria"
  s.version     = HitobitoPatria::VERSION
  s.authors     = ["Your name"]
  s.email       = ["Your email"]
  #s.homepage    = "TODO"
  s.summary     = "Patria"
  s.description = "Wagon description"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["test/**/*"]
  
  s.add_dependency "devise_ldap_authenticatable", ">=0"


end
