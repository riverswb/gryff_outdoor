require 'rails_helper'

RSpec.describe Category, type: :model do
  scenario 'cant be created without a name' do
    valid_category = Category.create!(name: "Fishing")
    invalid_category = Category.create()

    expect(valid_category).to be_valid
    expect(invalid_category).to be_invalid
  end

  scenario 'can have items' do
    category = Category.create!(name: 'Fishing')

    expect(category).to respond_to(:items)
  end
end