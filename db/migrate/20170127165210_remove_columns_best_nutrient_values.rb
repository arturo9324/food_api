class RemoveColumnsBestNutrientValues < ActiveRecord::Migration[5.0]
  def self.up
  	remove_column :best_nutrient_values, :optimo
    remove_column :best_nutrient_values, :maximo
    remove_column :best_nutrient_values, :minimo
    add_column :best_nutrient_values, :value, :float, scale: 3
  end

  def self.down
  	add_column :best_nutrient_values, :optimo, :float, scale: 3
    add_column :best_nutrient_values, :maximo, :float, scale: 3
    add_column :best_nutrient_values, :minimo, :float, scale: 3
    remove_column :best_nutrient_values, :value
  end
end
