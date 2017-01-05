FactoryGirl.define do
  factory :item do
    title       {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence }
    price       {Faker::Commerce.price}
    image "http://lorempixel.com/400/200/"
    category
  end

  factory :category do
    name  { [:hiking, :fishing, :climbing].sample }
    
    factory :category_with_items do
      after(:create) do |category|
        create_list(:item, 10, category: category)
      end
    end
  end
end
