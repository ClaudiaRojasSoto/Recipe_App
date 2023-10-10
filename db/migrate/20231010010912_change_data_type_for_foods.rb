class ChangeDataTypeForFoods < ActiveRecord::Migration[7.0]
  def up
    change_column :foods, :price, :decimal, precision: 8, scale: 2, null: false
    change_column :foods, :quantity, :decimal, precision: 8, scale: 2, null: false
  end

  def down
    change_column :foods, :price, :integer
    change_column :foods, :quantity, :integer
  end
end
