class CreateAgeGroupCounts < ActiveRecord::Migration
  def change
    create_table :age_group_counts do |t|
      t.integer :member_count_id
      t.integer :birth_year
      t.integer :count_m
      t.integer :count_f
    end
  end
end