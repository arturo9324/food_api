require 'rails_helper'

RSpec.describe Portion, type: :model do

	it { should belong_to(:product) }
	it { should belong_to(:measure) }
	it { should validate_numericality_of(:porcion).is_greater_than(0).is_less_than(99) }
	it { should validate_numericality_of(:cantidad).is_greater_than(0.0) }
end
