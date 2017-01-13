FactoryGirl.define do
	factory :has_nutrient do
		association :product, factory: :product
		association :nutrient, factory: :nutrient
		cantidad 5.0
	end
end