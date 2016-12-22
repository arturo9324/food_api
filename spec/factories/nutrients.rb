FactoryGirl.define do
	factory :nutrient do
		sequence(:nombre) { |n| "nutriente #{n}" }
		association :measure, factory: :measure
	end
end