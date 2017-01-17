require 'rails_helper'

RSpec.describe InfoAppUser, type: :model do

	it { should belong_to(:app_user) }
	it { should validate_presence_of(:fecha_nacimiento) }
	it { should allow_value("1998-1-12").for(:fecha_nacimiento) }
	it { should_not allow_value("2006-31-12").for(:fecha_nacimiento) }
	it { should_not allow_value("fecha").for(:fecha_nacimiento) }
	it { should validate_numericality_of(:peso) }
	it { should validate_numericality_of(:estatura) }
	it { should validate_numericality_of(:max_calorias) }
	it { should validate_numericality_of(:min_calorias) }

end
