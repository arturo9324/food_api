FactoryGirl.define do
  factory :product do
  	association :user, factory: :user 
    nombre "Producto prueba"
    codigo "1234567890"
    cantidad 15
    calorias 15
    image_file_name { Faker::Avatar.image }
    porciones false
  end
end
