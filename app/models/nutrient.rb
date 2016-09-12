class Nutrient < ApplicationRecord
	validates :nombre, presence: true, uniqueness: true

	has_many :has_nutrients
	has_many :products, through: :has_nutrients
	has_one :measure
end
