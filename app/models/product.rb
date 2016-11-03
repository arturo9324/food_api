class Product < ApplicationRecord
	

	validates :nombre, presence: true, uniqueness: true
	validates :cantidad, presence: true
	validates :calorias, presence: true
	validates :codigo, presence: true, uniqueness: true
	validates_inclusion_of :porciones, :in => [true, false]

	has_attached_file :image, styles: { web: "600x400", mobile: "300x200" }
	validates_attachment_presence :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	has_many :has_nutrients
	has_many :nutrients, through: :has_nutrients

	belongs_to :user 
 
	def get_nutrient(nutrient_id)
		has = HasNutrient.where("product_id = ? AND nutrient_id = ?", self.id, nutrient_id).take
		has.cantidad
	end

	scope :ultimos, ->{ order("created_at DESC") }
end
