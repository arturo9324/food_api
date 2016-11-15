class Company < ApplicationRecord
  belongs_to :user,  -> { where admin: false }

  validates :nombre, presence: true, uniqueness: true
  validates :direccion, presence: true, length: { :minimum =>30 }
  
  validates_plausible_phone :telefono, presence: true

  before_validation :set_phone

  private 

  def set_phone
  	self.telefono = PhonyRails.normalize_number(self.telefono, country_code: 'MX')
  end

end
