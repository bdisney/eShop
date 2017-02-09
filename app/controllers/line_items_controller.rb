class LineItemsController < ApplicationController
  include CurrentCart
  load_and_authorize_resource except: :create
  skip_authorization_check only: [:create, :destroy]
  skip_before_action :authenticate_user!, only: [:create, :increment, :decrement, :destroy] 
  before_action :set_cart, only: :create
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    redirect_to store_url, notice: 'Nothing interesting.'
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    redirect_to store_url, notice: 'Nothing interesting.'

  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to :back }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end


def increment
  @cart = Cart.find(session[:cart_id])
  @line_item = LineItem.find_by_id(params[:id])

  # did it in the cart-model first, but that does not allow to redirect correctly
  if @line_item.quantity >= 1
    @line_item.quantity += 1
    if @line_item.save
      respond_to do |format|
        format.html { redirect_to cart_url(@cart), notice: 'Line item was successfully decreased.' }
        format.js { @current_item = @line_item }
       format.json { head :ok }
      end
    end
  else
    # call the destroy-method and run all associated
    LineItem.destroy(@line_item)
  end
end



# POST /line_items
# POST /line_items.json


def decrement
  @cart = Cart.find(session[:cart_id])
  @line_item = LineItem.find_by_id(params[:id])

  # did it in the cart-model first, but that does not allow to redirect correctly
  if @line_item.quantity > 1
    @line_item.quantity -= 1
    if @line_item.save
      respond_to do |format|
        format.html { redirect_to cart_url(@cart), notice: 'Line item was successfully decreased.' }
        format.js { @current_item = @line_item }
       format.json { head :ok }
      end
    end
  else
    # call the destroy-method and run all associated
    LineItem.destroy(@line_item)
  end
end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @cart = current_cart
   
    LineItem.destroy(@line_item)
    if @cart.line_items.empty?
      redirect_to store_url, notice: 'Your cart is now empty'
    else
      respond_to do |format|
      format.html { redirect_to :back }
      
      format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

    

end
