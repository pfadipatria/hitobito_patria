module TotalFromAgeGroups
  
  def total_from_age_groups
    total = 0
    age_group_counts.each do |age_group|
      total += age_group.count_m.to_i
      total += age_group.count_f.to_i
    end
    total
  end  
  
end