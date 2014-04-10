Rails.application.routes.draw do

  as :person do
    get 'users/editldap' => 'devise/registrations#editldap', :as => 'edit_person_registration_ldap'
  end

end
