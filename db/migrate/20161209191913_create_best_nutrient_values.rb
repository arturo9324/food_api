class CreateBestNutrientValues < ActiveRecord::Migration[5.0]
  def change
    create_table :best_nutrient_values do |t|
      t.references :app_user, foreign_key: true
      t.references :nutrient, foreign_key: true
      t.float :optimo, scale: 2
      t.float :maximo, scale: 2
      t.float :minimo, scale: 2

      t.timestamps
    end
  end
end
