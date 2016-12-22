FactoryGirl.define do
	factory :disease do
		sequence(:nombre) { |n| "enfermedad #{n}"}
	end
end