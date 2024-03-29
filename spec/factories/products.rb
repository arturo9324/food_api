FactoryGirl.define do
  factory :product do
  	association :user, factory: :user
  	association :measure, factory: :measure 
    nombre "Producto prueba"
    codigo "1234567890"
    cantidad 15
    calorias 15
    image_file_name { Faker::Avatar.image }
  end
end
