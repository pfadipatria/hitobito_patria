# == Schema Information
#
# Table name: age_group_censuses
#
#  id                 :integer          not null, primary key
#  kantonalverband_id :integer          not null
#  region_id          :integer
#  abteilung_id       :integer          not null
#  year               :integer          not null
#  age_group          :integer          not null
#  males              :integer
#  females            :integer
#
class AgeGroup < ActiveRecord::Base

  belongs_to :abteilung, class_name: 'Group::Abteilung'
  belongs_to :region, class_name: 'Group::Region'
  belongs_to :kantonalverband, class_name: 'Group::Kantonalverband'

end
