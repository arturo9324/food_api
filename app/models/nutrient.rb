class Nutrient < ApplicationRecord
	validates :nombre, presence: true, uniqueness: {:case_sensitive => false}

	has_many :has_nutrients
	has_many :products, through: :has_nutrients
	belongs_to :measure, required: true
	has_many :best_nutrient_values
	has_many :eaten_nutrients
end
