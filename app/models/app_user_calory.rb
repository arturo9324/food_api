class AppUserCalory < ApplicationRecord

	belongs_to :app_user, required: true
	validates_numericality_of :gasto, presence: true, greater_than: 0.0 
	validates :fecha, presence: true, :timeliness => {:on_or_after => "2017/05/04".to_date, :type => :date }
	

	scope :fecha, -> (fecha) { where("fecha = ?", fecha) }

	scope :hoy, -> { where("app_user_calories.created_at >= ?", Time.zone.now.beginning_of_day) }

	scope :grupo, -> { group("app_user_calories.created_at") }

	scope :suma, -> { select("SUM(gasto) AS gasto")}

	def classname
		"AppUserCalory"
	end
end 