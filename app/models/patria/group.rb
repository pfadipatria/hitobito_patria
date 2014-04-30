module Patria::Group
  extend ActiveSupport::Concern
  
 
  
   included do 

    roles Neumitglied 
  end
  
     class Neumitglied < ::Role
    self.permissions = []
  end
end
