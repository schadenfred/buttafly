class AddOriginableHeaderColumnToButtaflyLegends < ActiveRecord::Migration[5.1]
  def change
    add_column :buttafly_legends, :originable_headers, :string
  end
end
