class CreateAgeGroupCounts < ActiveRecord::Migration
  def change
    create_table :age_group_counts do |t|
	  t.integer :member_count_id
      t.integer :birth_year, null: false
      t.integer :males, :default => 0
      t.integer :females, :default => 0
    end
  end
end