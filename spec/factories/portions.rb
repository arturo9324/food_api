FactoryGirl.define do
  factory :portion do
    association :product, factory: :product
    association :measure, factory: :measure
    porcion 1
    cantidad 1.5
    equivalencia "MyString 123445"
  end
end
