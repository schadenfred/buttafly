# This migration comes from buttafly (originally 20180206230853)
class AddAasmStateToButtaflyMappings < ActiveRecord::Migration[5.1]
  def change
    add_column :buttafly_mappings, :aasm_state, :string
  end
end
