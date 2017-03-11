class Measure < ApplicationRecord
	has_many :products
	has_many :nutrients
	validates :nombre, presence: true
	validates :abreviacion, presence: true

	scope :productos, -> { where("measures.id IN (?)", [1, 2, 3, 4, 5])}

	scope :nutrientes, -> { where("measures.id IN (?)", [5, 6, 7, 8])}

	scope :porcion, -> { where("measures.id IN (?)", [2, 5])}
end
