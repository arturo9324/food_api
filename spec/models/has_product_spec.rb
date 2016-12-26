require 'rails_helper'

RSpec.describe HasProduct, type: :model do

	it { should belong_to(:product) }
	it { should belong_to(:app_user) }
	it { should validate_numericality_of(:porciones).is_greater_than(0.0) }
	it { should validate_numericality_of(:cantidad).is_greater_than(0.0) }
end
