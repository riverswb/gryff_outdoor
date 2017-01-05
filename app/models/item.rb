class Item < ApplicationRecord

  validates :title,:description, :price, :image, presence: :true
end
