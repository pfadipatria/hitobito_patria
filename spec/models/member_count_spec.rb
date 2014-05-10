require 'spec_helper'

describe MemberCount do

  let(:be)   { groups(:be) }
  let(:zh)   { groups(:zh) }
  let(:schekka)   { groups(:schekka) }
  let(:berchtold) { groups(:berchtold) }
  let(:chaeib)    { groups(:chaeib) }

  describe '.age_total_by_abteilungen' do

    subject { MemberCount.age_total_by_abteilungen(2012, be).to_a }

    it 'counts totals' do
      should have(2).items

      schekka_count = subject.detect { |c| c.abteilung_id == schekka.id }
      assert_age_group_counts(schekka_count, {2001 => {m: 1, f: 2}, 2002 => {m: 3, f: 2}, 1998 => {m: 2, f: 2}})

      berchtold_count = subject.detect { |c| c.abteilung_id == berchtold.id }
      assert_age_group_counts(berchtold_count, {2001 => {m: 2, f: 2}, 2002 => {m: 3, f: 0}})
    end
  end

  describe '.age_total_for_abteilungen' do
    subject { MemberCount.age_total_for_abteilung(2012, schekka) }

    it 'counts totals' do
      assert_age_group_counts(subject, {2001 => {m: 1, f: 2}, 2002 => {m: 3, f: 2}, 1998 => {m: 2, f: 2}})
    end
  end

  describe '.age_total_for_bund' do
    subject { MemberCount.age_total_for_bund(2012) }

    it 'counts totals' do
      assert_age_group_counts(subject, {2001 => {m: 4, f: 6}, 2002 => {m: 9, f: 5}, 1998 => {m: 2, f: 2}})
    end
  end

  describe '.age_total_by_kantonalverbands' do

    subject { MemberCount.age_total_by_kantonalverbaende(2012).to_a }

    it 'counts totals' do
      should have(2).items

      be_count = subject.detect { |c| c.kantonalverband_id == be.id }
      assert_age_group_counts(be_count, {2001 => {m: 3, f: 4}, 2002 => {m: 6, f: 2}, 1998 => {m: 2, f: 2}})

      zh_count = subject.detect { |c| c.kantonalverband_id == zh.id }
      assert_age_group_counts(zh_count, {2001 => {m: 1, f: 2}, 2002 => {m: 3, f: 3}})

    end
  end

  def assert_age_group_counts(count, year_values)
    count.age_group_counts.each do |age_group_count|
      age_group_count.count_m.should == year_values[age_group_count.birth_year][:m]
      age_group_count.count_f.should == year_values[age_group_count.birth_year][:f]
    end
  end

end
