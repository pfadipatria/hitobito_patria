module Patria::Group::Abteilung
  extend ActiveSupport::Concern
  
  def age_census_groups(year)
    []
  end

  def age_census_total(year)
    MemberCount.age_total_for_abteilung(year, self)
  end
end