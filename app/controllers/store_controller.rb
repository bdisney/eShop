class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authenticate_user!
  skip_authorization_check
  before_action :set_cart
  
  def index
    @products = Product.order(:title)
  end
end
