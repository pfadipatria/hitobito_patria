module Patria::Group
  extend ActiveSupport::Concern
  
 
  
   included do 

    roles Neuling
  end
  
     class Neuling < ::Role
    self.permissions = []
  end
end
