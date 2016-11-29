class AddMeasureReferencesToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :measure, foreign_key: true
  end
end
