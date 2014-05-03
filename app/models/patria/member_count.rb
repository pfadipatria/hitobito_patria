module Patria::MemberCount
  extend ActiveSupport::Concern
  
  include TotalFromAgeGroups
  
  included do
    has_many :age_group_counts, :dependent => :delete_all
  end

  module ClassMethods
    
    def age_total_by_kantonalverbaende(year)      
      state_ids = MemberCount
        .includes(:age_group_counts)
        .select(:kantonalverband_id)
        .where(year: year)
        .includes(:age_group_counts)
        .distinct
      
      counts = Array.new
      all_age_groups = AgeGroupCount.joins(:member_count).where(member_counts: { year: year })
      
      state_ids.each do |id|
        count = AgeGroupSum.new
        count.age_group_counts = all_age_groups
          .where(member_counts: { kantonalverband_id: id.kantonalverband_id })
          .group("age_group_counts.birth_year")
          .select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')

        count.kantonalverband_id = id.kantonalverband_id
        counts << count
      end
      counts
    end
  
    def age_total_by_abteilungen(year, state)
      MemberCount.where(year: year, kantonalverband_id: state.id).includes(:age_group_counts)
    end
  
    def age_total_for_bund(year)
      count = AgeGroupSum.new
      count.age_group_counts = AgeGroupCount
        .joins(:member_count)
        .where(member_counts: { year: year })
        .group("age_group_counts.birth_year")
        .select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')
      count
    end
    
    def age_total_for_kantonalverband(year, state)
      count = AgeGroupSum.new
      count.age_group_counts = AgeGroupCount
        .joins(:member_count)
        .where(member_counts: { kantonalverband_id: state.id, year: year })
        .group("age_group_counts.birth_year")
        .select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')
      count
    end
  
    def age_total_for_abteilung(year, abteilung)
      MemberCount.where(year: year, abteilung_id: abteilung.id).includes(:age_group_counts).first
    end
    
  end
  
end