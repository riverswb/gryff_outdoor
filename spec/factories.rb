FactoryGirl.define do
  factory :category do
    name  { [:hiking, :fishing, :climbing].sample }
  end

  factory :item do
    title       {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence }
    price       {Faker::Commerce.price}
    image "http://lorempixel.com/400/200/"
    category
  end

  factory :user do
    first_name "David"
    last_name "Knott"
    sequence :email do |n|
      "david#{n.to_s}@gmail.com"
    end
    password "123"
    password_confirmation "123"
  end

end
