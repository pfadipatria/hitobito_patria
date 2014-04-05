module Patria::MemberCount
  extend ActiveSupport::Concern
  
  included do
    has_many :age_group_counts
  end

  module ClassMethods
    
    def age_total_by_kantonalverbaende(year)
      totals_by(year, :kantonalverband_id)
    end
  
    def age_total_by_abteilungen(year, state)
      totals_by(year, :abteilung_id, kantonalverband_id: state.id)
    end
  
    def age_total_for_bund(year)
      totals_by(year, :year).first
    end
  
    def age_total_for_abteilung(year, abteilung)
  
      
 
      #totals_by(year, :abteilung_id, abteilung_id: abteilung.id).first
      count = MemberCount.new
      count.age_group_counts << AgeGroupCount.joins(:member_count).where(member_counts: { abteilung_id: abteilung.id }).order(birth_year: :desc)
      count
    end
  
    def totals(year)
      columns = 'kantonalverband_id, ' \
                'region_id, ' \
                'abteilung_id, ' +
                COUNT_COLUMNS.collect { |c| "SUM(#{c}) AS #{c}" }.join(',')
  
      select(columns).where(year: year)
    end
  
    private
  
    def totals_by(year, group_by, conditions = {})
      totals(year).where(conditions).group(group_by)
    end
  end
  
end