module Patria::Devise::PasswordsController
  extend ActiveSupport::Concern
  
  included do
   
    def create
      config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
      user = Person.where("email = ?", params["person"]["email"]).first
      
      if user.nil?
        redirect_to :back, :alert => config['no_hitobito_user']
      else 
        if user.ldap_user?
          redirect_ldap_user
        else 
          self.resource = resource_class.send_reset_password_instructions(resource_params)
          yield resource if block_given?
  
          if successfully_sent?(resource)
            respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
          else
            respond_with(resource)
          end
        end
      end
      
      rescue Net::LDAP::LdapError
        redirect_to :back, :alert => config['no_ldap_no_password_change']
        
    end

    def redirect_ldap_user      
      if config['use_text']
        redirect_to :back, :alert => config['call_administrator']
      else
        redirect_to(config['ldap_new_password'])
      end
    end

  end
  
end