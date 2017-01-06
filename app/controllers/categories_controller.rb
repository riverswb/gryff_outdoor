class CategoriesController < ApplicationController

def index
  @category = Category.find_by(name: params[:category])
end

end