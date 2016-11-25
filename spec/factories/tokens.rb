FactoryGirl.define do
  factory :token do
  	association :app_user, factory: :app_user
    expires_at "2016-11-25 08:41:02"  end
end
