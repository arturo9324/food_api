class HasDisease < ApplicationRecord

	belongs_to :info_app_user, required: true
	belongs_to :disease, required: true

	def classname
		"HasDisease"
	end
end