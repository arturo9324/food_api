require 'rails_helper'

RSpec. describe Measure, type: :model do

	it { should validate_presence_of(:nombre) }
	it { should validate_presence_of(:abreviacion) }
	
end