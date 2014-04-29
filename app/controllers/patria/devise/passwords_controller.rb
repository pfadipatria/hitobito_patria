module Patria::Devise::PasswordsController
  extend ActiveSupport::Concern
  
  included do
   
    def create
      user = Person.where("email = ?", params["person"]["email"]).first
      config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
      
      if user.nil?
        flash[:alert] = config['no_hitobito_user']
        redirect_to(:back)
      else 
        if user.ldap_user?
        
          if config['use_text']
            flash[:alert] = config['call_administrator']
            redirect_to(:back)
          else
            redirect_to(config['ldap_new_password'])
          end
          
        else 
          flash[:alert] = config['no_ldap_user']
          redirect_to(:back)
        end
      end
    end
  end
  
end