module CurrentCart
  extend ActiveSupport::Concern

  private
  
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Carte.create
      session[:cart_id] = @cart.cart_id
    end
end