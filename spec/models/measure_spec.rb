require 'rails_helper'

Rspec. describe Measure, type: :model do

	it { should validate_precence_of(:nombre) }
	it { should validate_precence_of(:abrebiacion) }
	
end