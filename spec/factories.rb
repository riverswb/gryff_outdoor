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
    first_name  {Faker::Name.first_name}
    last_name   {Faker::Name.last_name }
    email       {Faker::Internet.email}
    password    "abc"
    password_confirmation "abc"
  end
end
