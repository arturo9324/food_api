class HasNutrient < ApplicationRecord
	belongs_to :product, required: true
	belongs_to :nutrient, required: true

	validates_numericality_of :cantidad, presence: true, greater_than: 0.0

	def classname
		"HasNutrient"
	end
end
