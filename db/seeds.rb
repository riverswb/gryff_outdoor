category_1 = Category.create(name: 'hiking')
category_2 = Category.create(name: 'fishing')
category_3 = Category.create(name: 'climbing')

30.times do
  Item.create(
    title:       Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    price:       Faker::Commerce.price,
    image: "http://lorempixel.com/400/200/",
    category:    [category_1, category_2, category_3].sample
  )
end

user = User.create(first_name: "Harry", last_name: "Potter", email: "harry@potter.com",
            password: "a", password_confirmation: "a", role: 1)
Address.create(street_address:"4747 Poplar Place", city:"Boulder", state_abbr:"CO", zip_code:"80304", user_id: user.id)
Address.create(street_address:"4748 Poplar Place", city:"Boulder", state_abbr:"CO", zip_code:"80304", user_id: user.id)
Address.create(street_address:"4749 Poplar Place", city:"Boulder", state_abbr:"CO", zip_code:"80304", user_id: user.id)
Address.create(street_address:"4750 Poplar Place", city:"Boulder", state_abbr:"CO", zip_code:"80304", user_id: user.id)
