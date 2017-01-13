FactoryGirl.define do
	factory :eaten_nutrient do
		association :has_product, factory: :has_product
		association :nutrient, factory: :nutrient
		cantidad 1.5
	end
end