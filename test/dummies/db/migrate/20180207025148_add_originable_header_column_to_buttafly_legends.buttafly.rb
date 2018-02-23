# This migration comes from buttafly (originally 20180207024519)
class AddOriginableHeaderColumnToButtaflyLegends < ActiveRecord::Migration[5.1]
  def change
    add_column :buttafly_legends, :originable_headers, :string
  end
end
