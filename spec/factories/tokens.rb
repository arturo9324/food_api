FactoryGirl.define do
  	factory :token do
  		association :app_user, factory: :app_user
    	expires_at 3.months.from_now
	end
end
