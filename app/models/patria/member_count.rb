module Patria::MemberCount
  extend ActiveSupport::Concern
  
  included do
    has_many :age_group_counts
  end
  
  def total_from_age_groups
    total = 0
    age_group_counts.each do |age_group|
      total += age_group.count_m.to_i
      total += age_group.count_f.to_i
    end
    total
  end  

  module ClassMethods
    
    def age_total_by_kantonalverbaende(year)      
      state_ids = MemberCount.select(:kantonalverband_id).where(year: year).distinct
      
      counts = Array.new
      state_ids.each do |id|
        count = MemberCount.new
        #count.age_group_counts << AgeGroupCount.joins(:member_count).where(member_counts: { kantonalverband_id: id.kantonalverband_id, year: year }).group("age_group_counts.birth_year").select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')
        
        #count.age_group_counts << AgeGroupCount.joins(:member_count).where(member_counts: { kantonalverband_id: id.kantonalverband_id, year: year }).group("age_group_counts.birth_year").select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')
        counts << count
        Rails.logger.info count.inspect
      end
      Rails.logger.info "BLABLABLABALBALBALBALBALBALLALSLLAALAL"
      Rails.logger.info counts.inspect
      counts
    end
  
    def age_total_by_abteilungen(year, state)
      MemberCount.where(year: year, kantonalverband_id: state.id).includes(:age_group_counts)
    end
  
    def age_total_for_bund(year)
      count = MemberCount.new
      count.age_group_counts << AgeGroupCount.joins(:member_count).where(member_counts: { year: year }).group("age_group_counts.birth_year").select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')
      count
    end
    
    def age_total_for_kantonalverband(year, state)
      count = MemberCount.new
      count.age_group_counts << AgeGroupCount.joins(:member_count).where(member_counts: { kantonalverband_id: state.id, year: year }).group("age_group_counts.birth_year").select('member_count_id, birth_year, sum(count_m) as count_m, sum(count_f) as count_f')
      count
    end
  
    def age_total_for_abteilung(year, abteilung)
      MemberCount.where(year: year, abteilung_id: abteilung.id).includes(:age_group_counts).first
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