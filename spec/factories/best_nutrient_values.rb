FactoryGirl.define do
  factory :best_nutrient_value do
    association :app_user, factory: :app_user
    association :nutrient, factory: :nutrient
    optimo 1.5
    maximo 1.5
    minimo 1.5
  end
end
