class Measure < ApplicationRecord
	has_many :products
	validates :nombre, presence: true
	validates :abrebiacion, presence: true
end
