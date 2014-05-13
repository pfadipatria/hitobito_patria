module Patria::Devise::SessionsController
  extend ActiveSupport::Concern
  
  included do

    # GET /resource/sign_in
    def new
      check_ldap_connection
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      respond_with(resource, serialize_options(resource))
    end

    # tries to connect to ldap-server (with any login), catches the LdapError if there's no connection
    def check_ldap_connection
      Devise::LDAP::Adapter.get_ldap_entry("Login")
    rescue Net::LDAP::LdapError
      config = YAML.load_file("#{Rails.root.parent}/hitobito_patria/config/config.yml")
      flash[:alert] = config['no_ldap_connection']
    end

  end
end
