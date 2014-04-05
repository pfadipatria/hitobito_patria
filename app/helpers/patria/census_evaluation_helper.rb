module Patria::CensusEvaluationHelper
  extend ActiveSupport::Concern
  
  #TODO Why is the const. not inherited from the original Helper?
  EMPTY_COUNT_VALUE = '-'

  def age_count_field(group, birth_year, gender)
    if (count = @group_counts[group.id])
      age_group = count.age_group_counts.select { |age_group_count| age_group_count.birth_year == birth_year }.first
      count_value(age_group.send("count_#{gender}"))
    else
      EMPTY_COUNT_VALUE
    end
  end
  
  def age_total_count_field(birth_year, gender)
    age_group = @total.age_group_counts.select { |age_group_count| age_group_count.birth_year == birth_year }.first
    if age_group
      count_value(age_group.send("count_#{gender}"))
    else 
      EMPTY_COUNT_VALUE
    end
  end
  
end