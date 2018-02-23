# This migration comes from buttafly (originally 20180209232638)
class AddNameToButtaflyLegends < ActiveRecord::Migration[5.1]
  def change
    add_column :buttafly_legends, :name, :string
  end
end
