class Product < ApplicationRecord
	
	include AASM

	validates :nombre, presence: true, uniqueness: true, :length => { :minimum => 5 }
	validates_numericality_of :cantidad, presence: true, :greater_than => 0.0
	validates_numericality_of :calorias, presence: true, :greater_than => 0
	validates :codigo, presence: true, uniqueness: true, length: { minimum: 8, maximum: 15 }
	#validates_inclusion_of :porciones, :in => [true, false]

	has_attached_file :image, styles: { web: "600x400", mobile: "300x200" }
	validates_attachment_presence :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	has_many :has_nutrients, dependent: :destroy
	has_many :nutrients, through: :has_nutrients
	belongs_to :measure, required: true
	belongs_to :user, required: true
	has_one :portion, dependent: :destroy
	has_many :has_product
	has_many :app_users, through: :has_product
 
	def get_nutrient(nutrient_id)
		has = HasNutrient.where("product_id = ? AND nutrient_id = ?", self.id, nutrient_id).take
		has.cantidad
	end

	scope :ultimos, ->{ order("state ASC, created_at DESC") }

	aasm column: "state" do
		state :on_hold, initial: true
		state :published

		event :publish do
			transitions from: :on_hold, to: :published
		end

		event :unpublish do
			transitions from: :published, to: :on_hold
		end
	end
end
