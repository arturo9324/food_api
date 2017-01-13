require 'rails_helper'

RSpec.describe AppUserCalory, type: :model do

	it { should belong_to(:app_user) }
	it { should  validate_numericality_of(:gasto).is_greater_than(0.0) }
end