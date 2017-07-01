FactoryGirl.define do
	factory :app_user_calory do
		association :app_user, factory: :app_user
		gasto 1.6
		fecha DateTime.now.to_date
	end
end