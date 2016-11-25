require 'rails_helper'

RSpec.describe Nutrient, type: :model do

	it { should validate_presence_of(:nombre) }
	it { should validate_uniqueness_of(:nombre).case_insensitive }
	it { should have_many(:has_nutrients) }
	it { should have_many(:products).through(:has_nutrients) }
	
end