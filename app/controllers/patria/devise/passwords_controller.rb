module Patria::Devise::PasswordsController
  extend ActiveSupport::Concern
  
  included do
   
    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      user = Person.where("email = ?", params["person"]["email"]).first
      if user.nil?
        respond_with(resource)
      else 
        if user.ldap_user?
          config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
          redirect_to(config['ldap_new_password'])
        else 
          flash[:alert] = "E-Mail nicht im LDAP"
          redirect_to(:back)
        end
      end
       
    end
  end
   
end