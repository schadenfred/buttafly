class AddNameToButtaflyLegends < ActiveRecord::Migration[5.1]
  def change
    add_column :buttafly_legends, :name, :string
  end
end
