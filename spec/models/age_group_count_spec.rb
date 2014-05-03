# encoding: utf-8

#  Copyright (c) 2014, Pfadicorps Patria Bern. This file is part of
#  hitobito_patria and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/pfadipatria/hitobito_patria.

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
require 'spec_helper'

describe AgeGroupCount do

  let(:patria)   { groups(:patria) }

  describe 'counts totals' do

    subject { AgeGroupCount.where(birth_year: 2003).first }

    it 'has minimum' do
      
      subject.count_m.should eq(4)
      subject.count_f.should eq(6)
    end
  end
end
