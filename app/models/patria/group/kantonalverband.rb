module Patria::Group::Kantonalverband
  extend ActiveSupport::Concern

  def age_census_total(year)
    MemberCount.age_total_by_kantonalverbaende(year).where(kantonalverband_id: id).first
  end

  def age_census_groups(year)
    MemberCount.age_total_by_abteilungen(year, self)
  end
end
