module Patria::CensusEvaluation
  extend ActiveSupport::Concern
  
  def age_counts_by_sub_group
    if sub_group_type
      sub_group_field = :"#{sub_group_type.model_name.element}_id"
      group.age_census_groups(year).inject({}) do |hash, count|
        hash[count.send(sub_group_field)] = count
        hash
      end
    end
  end
  
  def age_total
    group.age_census_total(year)
  end
  
  def min_birth_year
    AgeGroupCount.minimum("birth_year")
  end
  
  def max_birth_year
    AgeGroupCount.maximum("birth_year")
  end
end
