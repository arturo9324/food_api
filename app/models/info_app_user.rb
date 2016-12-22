class InfoAppUser < ApplicationRecord
  	belongs_to :app_user, required: true
  	has_many :has_diseases
  	has_many :diseases, through: :has_diseases

 	validates :fecha_nacimiento, presence: true, :timeliness => { :before => lambda { 10.years.ago }, :type => :date }
	validates_numericality_of :peso, presence: true, :greater_than_or_equal_to => 30, :less_than => 200
	validates_numericality_of :estatura, presence: true, :greater_than_or_equal_to => 35, :less_than => 300
	validates_inclusion_of  :sexo, presence: true, :in => [true, false]
	validates_numericality_of :max_calorias, presence: true
	validates_numericality_of :min_calorias, presence: true
	validates_inclusion_of :embarazo, presence: true, :in => [true, false] 
	validates_inclusion_of :lactancia, presence: true, :in => [true, false] 


end
