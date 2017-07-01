FactoryGirl.define do
	factory :has_product do
		association :product, factory: :product
		association :app_user, factory: :app_user
		association :measure, factory: :measure
		porciones 1.5
		cantidad 100
		calories 100
	end
end