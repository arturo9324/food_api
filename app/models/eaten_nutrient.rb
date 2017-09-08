class EatenNutrient < ApplicationRecord
	
	belongs_to :nutrient, required: true
	belongs_to :has_product, optional: true
	validates_numericality_of :cantidad, presence: true, greater_than: 0.0 

	scope :suma, -> { select("nutrient_id, sum(eaten_nutrients.cantidad) AS cantidad") }

	scope :grupo, -> { group("nutrient_id, eaten_nutrients.created_at") }

	scope :fecha, -> (fecha) { having("DATE(eaten_nutrients.created_at) = ?", fecha) }

	scope :hoy, -> { having("eaten_nutrients.created_at >= ?", Time.zone.now.beginning_of_day) }

	def classname
		"EatenNutrient"
	end
end
