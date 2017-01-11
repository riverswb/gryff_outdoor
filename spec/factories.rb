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
    #status { [:ordered, :paid, :cancelled, :completed].sample }
    user
    items {create_list(:item, 5)}
  end

  factory :address do
    user
    street_address {Faker::Address.street_address}
    secondary_address {Faker::Address.secondary_address}
    city {Faker::Address.city}
    state_abbr {Faker::Address.state_abbr}
    zip_code {Faker::Address.zip_code}
  end


  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    password "123"
    password_confirmation "123"

    factory :user_with_addresses do
      after(:create) do |user|
        create_list(:address, 2, user: user)
      end
    end

    factory :user_with_orders do
      after(:create) do |user|
        create_list(:order, 10, user: user)
      end
    end
  end

  factory :order_item do
    item
    order
    quantity  2
  end

end