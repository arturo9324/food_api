class HasProduct < ApplicationRecord
	
	belongs_to :product, required: true
	belongs_to :app_user, required: true
	has_many :eaten_nutrients
	delegate :eaten_nutrients, to: :app_user

	validates_numericality_of :porciones, presence: true, greater_than: 0.0
	validates_numericality_of :cantidad, presence: true, greater_than: 0.0
	validates_numericality_of :calories, presence: true, greater_than: 0.0

	scope :fecha, -> (fecha) { where("DATE(created_at) = ?", fecha) }

	scope :hoy, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }

	def classname
		"HasProduct"
	end
end