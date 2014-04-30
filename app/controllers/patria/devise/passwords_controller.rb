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
          self.resource = resource_class.send_reset_password_instructions(resource_params)
          yield resource if block_given?
  
          if successfully_sent?(resource)
            respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
          else
            respond_with(resource)
          end

        end
      end
    end
  end
  
end