module Patria::MemberCount
  extend ActiveSupport::Concern
  
  included do
    has_many :age_group_counts
  end
end