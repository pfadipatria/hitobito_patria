module Patria::CensusEvaluationHelper
  extend ActiveSupport::Concern

  def age_count_field(count, birth_year, gender)
    if count
      age_group = count_by_birthyear(count, birth_year)
      if age_group
        return count_value(age_group.send("count_#{gender}"))
      end
    end
    CensusEvaluationHelper::EMPTY_COUNT_VALUE
  end
  
  def count_value_group_total(group)
    if (count = @group_counts[group.id])
      count_value(count.total_from_age_groups)
    else
      CensusEvaluationHelper::EMPTY_COUNT_VALUE
    end
  end
  
  def count_by_birthyear(count, birth_year)
    count.age_group_counts.select { |age_group_count| age_group_count.birth_year == birth_year }.first
  end
  
end