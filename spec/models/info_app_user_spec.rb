require 'rails_helper'

RSpec.describe InfoAppUser, type: :model do

	it { should validate_presence_of(:fecha_nacimiento) }
	it { should validate_presence_of(:peso) }
	it { should validate_presence_of(:estatura) }
	it { should validate_presence_of(:sexo) }
	it { should validate_presence_of(:max_calorias) }
	it { should validate_presence_of(:min_calorias) }
	it { should validate_presence_of(:embarazo) }
	it { should validate_presence_of(:lactancia) }
	it { should allow_value("2006-1-12").for(:fecha_nacimiento) }


end
