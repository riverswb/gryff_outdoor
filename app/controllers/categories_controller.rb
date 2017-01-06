class CategoriesController < ApplicationController

def index
  byebug
  @category = Category.find_by(name: params[:category])
end

end