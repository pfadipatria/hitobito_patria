module Patria::Devise::PasswordsController
  extend ActiveSupport::Concern
  
  included do
  	
  end
    
  def create
    if Person.where("email = ?", params["person"]["email"]).first.ldap_user?
      config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
      redirect_to("config['ldap_new_password']")
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