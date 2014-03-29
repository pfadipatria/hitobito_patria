class CreateAgeGroupCounts < ActiveRecord::Migration
  def change
    create_table :age_group_count do |t|
	  t.integer :member_count_id
      t.integer :age_group, null: false
      t.integer :males
      t.integer :females
    end
  end
end