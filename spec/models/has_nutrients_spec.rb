require 'rails_helper'

RSpec.describe HasNutrient, type: :model do 

	it { should belong_to(:product) }
	it { should belong_to(:nutrient) }
	it { should validate_numericality_of(:cantidad).is_greater_than(0.0) }

end