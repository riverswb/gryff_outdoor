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

  factory :order do
    status { [:ordered, :paid, :cancelled, :completed].sample }
    user
    items {[FactoryGirl.create(:item)]}
  end

  factory :user do
    first_name "David"
    last_name "Knott"
    sequence :email do |n|
      "david#{n.to_s}@gmail.com"
    end
    password "123"
    password_confirmation "123"

    factory :user_with_orders do
      after(:create) do |user|
        create_list(:order, 10, user: user)
      end
    end
  end

end
