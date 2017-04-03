class AddMeasureToHasProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :has_products, :measure, foreign_key: true
  end
end
