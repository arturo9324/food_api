class Measure < ApplicationRecord
	has_many :products
	has_many :nutrients
	validates :nombre, presence: true
	validates :abrebiacion, presence: true
end
