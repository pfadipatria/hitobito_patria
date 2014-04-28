module Patria::Devise::RegistrationsController
  extend ActiveSupport::Concern
  
  included do
  	
  end
    
  # if password wants to be changed by ldap-user, he'll be redirected to the link
  # defined at ldap_edit_password in config.yml
  def editldap
    config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
    redirect_to(config['ldap_edit_password'])
  end
  
end
