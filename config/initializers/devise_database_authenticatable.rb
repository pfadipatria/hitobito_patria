require 'devise/strategies/base'
require 'devise/strategies/database_authenticatable'
module Devise
  module Strategies
    class DatabaseAuthenticatable < Authenticatable
      def authenticate!
        resource  = valid_password? && mapping.to.find_for_database_authentication(authentication_hash)
        encrypted = false

        if validate(resource){ encrypted = true; resource.valid_password?(password) }
          if Person.where("email = ?", params["person"]["email"]).first.ldap_user?
            fail(:not_found_in_database)
          else
            resource.after_database_authentication
            success!(resource)
          end
        end

        mapping.to.new.password = password if !encrypted && Devise.paranoid
        fail(:not_found_in_database) unless resource
      end
    end
  end
end