class AddComlumnMeasureToNutrient < ActiveRecord::Migration[5.0]
  def change
    add_reference :nutrients, :measure, foreign_key: true
  end
end
