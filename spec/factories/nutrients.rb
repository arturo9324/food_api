FactoryGirl.define do
	factory :nutrient do
		sequence(:nombre) { |n| "nutriente #{n}" }
	end
end