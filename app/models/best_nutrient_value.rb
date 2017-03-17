class BestNutrientValue < ApplicationRecord
  	belongs_to :app_user, required: true
 	belongs_to :nutrient, required: true

 	validates_numericality_of :value, presence: true, greater_than: 0.0

  	def classname
		"BestNutrientValue"
	end
end
