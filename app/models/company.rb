class Company < ApplicationRecord
  belongs_to :user

  validates :nombre, presence: true, uniqueness: true
  validates :direccion, presence: true, length: { :minimum =>30 }
  
  validates_plausible_phone :telefono, presence: true

  before_save :normalize_number

  def normalize_number
  	self.telefono = PhonyRails.normalize_number(self.telefono)
  end
end
