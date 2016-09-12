class Measure < ApplicationRecord
	validates :nombre, presence: true
	validates :abrebicacion, presence: true
end
