require 'rails_helper'

RSpec.describe EatenNutrient, type: :model do

	it { should belong_to(:has_product) }
	it { should belong_to(:nutrient) }
	it { should validate_numericality_of(:cantidad).is_greater_than(0.0)}
end