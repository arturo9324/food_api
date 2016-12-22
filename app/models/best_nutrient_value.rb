class BestNutrientValue < ApplicationRecord
  belongs_to :app_user, required: true
  belongs_to :nutrient, required: true

  validates_numericality_of :optimo, presence: true, greater_than: 0.0
  validates_numericality_of :maximo, presence: true, greater_than: 0.0
  validates_numericality_of :minimo, presence: true, greater_than: 0.0
end
