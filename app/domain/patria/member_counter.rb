module Patria::MemberCounter
  extend ActiveSupport::Concern
  
  included do
    alias_method_chain :count, :age_group
  end

  def count_with_age_group
    count = count_without_age_group
    count_age_groups(count, members.includes(:roles))
    count
  end
  
  def count_age_groups(count, people)
    age_groups = Hash.new
    people.each do |person|
      year = person.birthday.year
      age_groups[year] ||= AgeGroupCount.new
      age_group = age_groups[year]
      age_group.birth_year = year
      if person.male?
        age_group.males = age_group.males ? age_group.males + 1 : 1
      else
        age_group.females = age_group.females ? age_group.females + 1 : 1
      end
    end
    
    age_groups.each do |key, value|
      count.age_group_counts << value
    end
  end
  
end