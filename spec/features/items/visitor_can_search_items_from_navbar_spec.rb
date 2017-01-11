require 'rails_helper'

RSpec.feature 'visitor can search for items from navbar' do
  before(:each) do
    a1 = create(:item, title: "a1")
    a2 = create(:item, title: "a2")
    b1 = create(:item, title: "b1")
    b2 = create(:item, title: "b2")

    visit items_path
  end

  
end
