class HasNutrient < ApplicationRecord
  belongs_to :product
  belongs_to :nutrient

  validates_numericality_of :cantidad, presence: true, greater_than: 0.0
end
