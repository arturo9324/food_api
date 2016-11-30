FactoryGirl.define do
  factory :info_app_user do
    association :app_user, factory: :app_user
    fecha_nacimiento "2016-11-25"
    peso 1.5
    estatura 1.5
    sexo false
    max_calorias 1.5
    min_calorias 1.5
    embarazo true
    lactancia false
  end
end
