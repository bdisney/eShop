class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authenticate_user!
  skip_authorization_check
  before_action :set_cart
  
  def index
    @categories = Category.all.map{|c| [ c.name, c.id ] }
    @category = MainCategory.find_by_name('All')
    @products = Product.order(:title)
  end
end
