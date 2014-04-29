module Patria::Devise::PasswordsController
  extend ActiveSupport::Concern
  
  included do
   
    def create
      user = Person.where("email = ?", params["person"]["email"]).first
      if user.nil?
        flash[:alert] = "E-Mail wurde noch nicht im Hitobito eingetragen, falls Sie einen Account im LDAP besitzen, melden Sie sich mit diesem auf der Startseite an."
        redirect_to(:back)
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