require 'rails_helper'

RSpec.describe HasDisease, type: :model do

	it { should belong_to(:info_app_user) }
	it { should belong_to(:disease) }

end