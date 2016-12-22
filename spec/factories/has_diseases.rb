FactoryGirl.define do
	factory :has_disease do
		association :disease, factory: :disease
		association :info_app_user, factory: :info_app_user
	end
end