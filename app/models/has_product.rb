class HasProduct < ApplicationRecord
	
	belongs_to :product, required: true
	belongs_to :app_user, required: true
	has_many :eaten_nutrients

	validates_numericality_of :porciones, presence: true, greater_than: 0.0
	validates_numericality_of :cantidad, presence: true, greater_than: 0.0

	scope :fecha, -> (fecha) { where("DATE(created_at) = ?", fecha) }

	scope :hoy, -> { where("DATE(created_at) = ?", Date.today) }
end