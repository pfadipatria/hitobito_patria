module Patria::Person
	extend ActiveSupport::Concern
  
  included do
    devise :ldap_authenticatable
    before_save :get_ldap_first_name
  	before_save :get_ldap_last_name 
  end
  
  def get_ldap_first_name
    self.first_name = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"givenName").first
  end
   
  def get_ldap_last_name
    self.last_name = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"sn").first
  end

end