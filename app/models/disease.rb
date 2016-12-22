class Disease < ApplicationRecord
	has_many :has_diseases
	has_many :info_app_users, through: :has_diseases

	validates :nombre, presence: true, length: { minimum: 5, maximum: 30 }, uniqueness: true
end