class CategoriesController < ApplicationController
  
  def index
    @category = Category.find_by(name: params[:category]) || not_found
  end

  private 
  def not_found
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end

end