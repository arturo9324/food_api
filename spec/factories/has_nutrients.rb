FactoryGirl.define do
	factory :has_nutrient do
		association :product, factory: :product
		cantidad 5.0
	end
end