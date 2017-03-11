require 'rails_helper'

RSpec.describe BestNutrientValue, type: :model do
  
  it { should belong_to(:app_user) }
  it { should belong_to(:nutrient) }
  it { should validate_numericality_of(:value).is_greater_than(0.0) }

end
