class CreateButtaflyTables < ActiveRecord::Migration[5.1]
  def change
    create_table :buttafly_legends do |t|
      t.text :data
      t.string :targetable_model
      t.string :originable_headers
      t.string :name

      t.timestamps
    end

    create_table :buttafly_mappings do |t|
      t.integer :legend_id
      t.integer :originable_id
      t.string :originable_type
      t.string :aasm_state

      t.timestamps
    end

    add_index :buttafly_mappings, [:originable_id, :originable_type]

    create_table :buttafly_artifacts do |t|
      t.integer :mapping_id
      t.text :data
      t.integer :status

      t.timestamps
    end


  end
end
