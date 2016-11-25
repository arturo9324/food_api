FactoryGirl.define do
  factory :token do
    expires_at "2016-11-23"
    app_users_id 1
    token "MyString"
  end
end
