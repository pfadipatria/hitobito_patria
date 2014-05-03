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
      increment(age_group(age_groups, person), count_field_without_role(person))
    end
    
    age_groups.each do |key, value|
      count.age_group_counts << value
    end
  end
  
  private
  
  def age_group(counts, person)
    if year = person.birthday
      year = year.year
    end
    counts[year] ||= AgeGroupCount.new
    age_group = counts[year]
    age_group.birth_year = year
    age_group
  end
  
  def count_field_without_role(person)
    person.male? ? :"count_m" : :"count_f"
  end
end