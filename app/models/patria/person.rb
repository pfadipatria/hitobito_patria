module Patria::Person
  extend ActiveSupport::Concern

  included do
    devise :ldap_authenticatable
    before_save :get_ldap_email
    before_save :get_ldap_first_name
    before_save :get_ldap_last_name
    before_save :get_ldap_nickname
  end

  def get_ldap_first_name
    firstname = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"givenName")
    self.first_name = firstname.first unless firstname == nil;
  rescue Net::LDAP::LdapError
  end

  def get_ldap_last_name
    lastname = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"sn")
    self.last_name = lastname.first unless lastname == nil;
  rescue Net::LDAP::LdapError
  end


  def get_ldap_nickname
    nickname = Devise::LDAP::Adapter.get_ldap_param(self.nickname,"cn")
    self.nickname = nickname.first unless nickname == nil;
  rescue Net::LDAP::LdapError
  end


  def get_ldap_email
    email = Devise::LDAP::Adapter.get_ldap_param(self.nickname, "mail")
    self.email = email.first unless email == nil;
    rescue Net::LDAP::LdapError
  end


  def ldap_user?
    Devise::LDAP::Adapter.get_ldap_param(self.nickname,"uid") != nil
  end

end