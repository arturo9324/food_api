FactoryGirl.define do
  factory :best_nutrient_value do
    association :app_user, factory: :app_user
    association :nutrient, factory: :nutrient
    value 1.5
  end
end
