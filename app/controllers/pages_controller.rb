class PagesController < ApplicationController
  include CurrentCart
  skip_before_action :authenticate_user!
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  skip_authorization_check
  
  def about
    @cart = current_cart
  end

  def faq
    @cart = current_cart
  end
    
 

  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
    end
end
