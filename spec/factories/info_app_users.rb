FactoryGirl.define do
  factory :info_app_user do
    app_users_id 1
    fecha_nacimiento "2016-11-23"
    peso 1.5
    estatura 1.5
    sexo false
    max_calorias 1.5
    min_calorias 1.5
    embarazo false
    lactancia false
  end
end
