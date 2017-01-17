FactoryGirl.define do
  factory :info_app_user do
    association :app_user, factory: :app_user
    fecha_nacimiento "1998-11-25"
    peso 50
    estatura 50
    sexo false
    max_calorias 30
    min_calorias 30
    embarazo false
    lactancia false
  end
end
