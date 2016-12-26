require 'rails_helper'

RSpec.describe Disease, type: :model do

	it { should validate_presence_of(:nombre) }
	it { should validate_uniqueness_of(:nombre) }
	it { should ensure_length_of(:nombre).is_at_least(5).is_at_most(30) }

end