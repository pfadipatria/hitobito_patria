module Patria::Person
	extend ActiveSupport::Concern
  
  included do
    devise :ldap_authenticatable
    before_save :get_ldap_first_name
  	before_save :get_ldap_last_name 
  end
  
  def get_ldap_first_name
    firstname = Devise::LDAP::Adapter.get_ldap_param(self.email,"givenName")
    self.first_name = firstname.first unless firstname == nil;
  rescue Net::LDAP::LdapError
  end
   
  def get_ldap_last_name
    lastname = Devise::LDAP::Adapter.get_ldap_param(self.email,"sn")
    self.last_name = lastname.first unless lastname == nil;
  rescue Net::LDAP::LdapError
  end

  def ldap_user?
    Devise::LDAP::Adapter.get_ldap_param(self.email,"uid") != nil
  end

end