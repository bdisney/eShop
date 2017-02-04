class ApplicationController < ActionController::Base
  #before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  check_authorization
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to store_url, :alert => exception.message
  end

  private

  def current_cart
      Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

  #protected
    def authorize
      if request.format == Mime::HTML
        unless User.find_by_id(session[:user_id])
          redirect_to login_url, notice: 'Please log in'
        end
      else
        authenticate_or_request_with_http_basic do |username, password|
          user = User.find_by_name(username)
          user && user.authenticate(password)
        end
      end
    end
end
