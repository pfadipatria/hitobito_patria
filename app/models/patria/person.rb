module Patria::Person
	extend ActiveSupport::Concern
  
  included do
    devise :ldap_authenticatable
    before_save :get_ldap_first_name
  	before_save :get_ldap_last_name 
  end
  
  def get_ldap_first_name
    firstname = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"givenName")
    self.first_name = firstname.first unless firstname == nil;
  end
   
  def get_ldap_last_name
    lastname = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"sn")
    self.last_name = lastname.first unless lastname == nil;
  end

  def ldap_user?
    Devise::LDAP::Adapter.get_ldap_param(self.nickname,"uid") != nil
  end

end