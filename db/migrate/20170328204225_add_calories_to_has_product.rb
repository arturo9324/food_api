class AddCaloriesToHasProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :has_products, :calories, :float
  end
end
