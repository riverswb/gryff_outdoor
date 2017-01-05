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

end
