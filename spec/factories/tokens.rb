FactoryGirl.define do
  factory :token do
<<<<<<< HEAD
    expires_at "2016-11-23"
    app_users_id 1
    token "MyString"
  end
=======
  	association :app_user, factory: :app_user
    expires_at "2016-11-25 08:41:02"  end
>>>>>>> 34854c68899985a9e68582cee0d9201d3ac60f1f
end
