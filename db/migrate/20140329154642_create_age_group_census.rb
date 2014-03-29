class CreateAgeGroupCensus < ActiveRecord::Migration
  def change
    create_table :age_group_censuses do |t|
      t.integer :kantonalverbund_id, null: false
      t.integer :region_id
      t.integer :abteilung_id, null: false
      t.integer :year, null: false
      t.integer :age_group, null: false
      t.integer :males
      t.integer :females
    end
    
    add_index :age_group_censuses, [:kantonalverband_id, :year]
    add_index :age_group_censuses, [:region_id, :year]
    add_index :age_group_censuses, [:abteilung_id, :year]
  end
end
