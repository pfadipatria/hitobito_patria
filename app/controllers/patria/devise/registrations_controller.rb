module Patria::Devise::RegistrationsController
  extend ActiveSupport::Concern
  
  included do
    def edit
      if current_user.ldap_user?
        redirect_to :action =>'editldap'
      else
        render :edit
      end
    rescue Net::LDAP::LdapError
      current_user.sign_out
    end
    	
  end
    
  # if password wants to be changed by ldap-user, he'll be redirected to the link
  # defined at ldap_edit_password in config.yml
  def editldap
    config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
    redirect_to(config['ldap_edit_password'])
  end

  
end
