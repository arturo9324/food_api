require 'rails_helper'

RSpec.describe AppUserCalory, type: :model do

	it { should belong_to(:app_user) }
	it { should validate_numericality_of(:gasto).is_greater_than(0.0) }
	it { should validate_presence_of(:fecha)}
	it { should allow_value("2017-05-04").for(:fecha) }
	it { should_not allow_value("2017-05-03").for(:fecha) }
end