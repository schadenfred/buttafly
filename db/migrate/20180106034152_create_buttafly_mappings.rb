class CreateButtaflyMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :buttafly_mappings do |t|
      t.integer :legend_id
      t.integer :originable_id
      t.string :originable_type

      t.timestamps


    end

    add_index :buttafly_mappings, [:originable_id, :originable_type]
  end
end
