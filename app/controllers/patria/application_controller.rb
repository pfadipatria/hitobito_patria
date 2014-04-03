module Patria::ApplicationController
  extend ActiveSupport::Concern
  
  included do
  	rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
   		render :text => exception, :status => 500
  	end
  end
end