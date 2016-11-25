require 'rails_helper'

RSpec.describe Token, type: :model do
  
  it { should belong_to(:app_user)}

end
