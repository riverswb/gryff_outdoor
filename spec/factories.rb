FactoryGirl.define do
  factory :item do
    title       {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence }
    price       {Faker::Commerce.price}
    image       {Faker::Internet.url('imgur.com')}
  end
end
