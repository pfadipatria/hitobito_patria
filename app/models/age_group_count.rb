# == Schema Information
#
# Table name: age_group_count
#
#  id                 :integer          not null, primary key
#  member_count_id    :integer          not null, foreign key
#  birth_year         :integer          not null
#  males              :integer
#  females            :integer
#
class AgeGroupCount < ActiveRecord::Base

  belongs_to :member_count
end
