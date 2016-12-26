class EatenNutrient < ApplicationRecord
	
	belongs_to :nutrient, required: true
	belongs_to :has_product, required: true
	has_one :app_user, through: :has_product
	validates_numericality_of :cantidad, presence: true, greater_than: 0.0 

	scope :suma, ->{ select("nutrient_id, sum(cantidad) as cantidad").group("nutrient_id") }

	scope :fecha, -> (fecha) { where("DATE(created_at) = ?", fecha)}
end