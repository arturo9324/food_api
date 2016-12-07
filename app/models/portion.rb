class Portion < ApplicationRecord
  belongs_to :product
  belongs_to :measure

  validates_numericality_of :porcion, presence: true, greater_than: 0, less_than: 99
  validates_numericality_of :cantidad, presence: true, greater_than: 0.0
  validates :equivalencia, presence: true, :length => { :minimum => 10 }
end
