class CreateEatenNutrient < ActiveRecord::Migration[5.0]
  def change
    create_table :eaten_nutrients do |t|
      t.references :nutrient, foreign_key: true
      t.references :has_product, foreign_key: true
      t.float :cantidad

      t.timestamps
    end
  end
end
