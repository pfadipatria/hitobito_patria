module Patria::Group::Bund
  extend ActiveSupport::Concern
  
  def age_census_total(year)
    MemberCount.age_total_for_bund(year)
  end

  def age_census_groups(year)
    MemberCount.age_total_by_kantonalverbaende(year)
  end
end

