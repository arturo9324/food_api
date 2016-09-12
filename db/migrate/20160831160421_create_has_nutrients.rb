class CreateHasNutrients < ActiveRecord::Migration[5.0]
  def change
    create_table :has_nutrients do |t|
      t.references :product, foreign_key: true
      t.references :nutrient, foreign_key: true
      t.float :cantidad

      t.timestamps
    end
  end
end
