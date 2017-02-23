class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:create, :show, :destroy]
  load_and_authorize_resource

  
  include CurrentCart
  before_action :set_cart
  
  

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if user_signed_in?
      @user_orders = Order.where(user_id: current_user.id).order('created_at DESC' )
      @user_reviews = Review.where(user_id: current_user.id)
    else
      respond_to do |format|
        format.html {redirect_to new_user_session_path, notice: "You should to be logged in"}
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { render :show, notice: "User '#{@user.username}' was successfully created." }
        format.json { }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user, :bypass => true)
        format.html { redirect_to store_url, notice: "User '#{@user.username}' was successfully updated." }
        format.json {  }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js {flash.now[:notice] = "Here is my flash notice" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
      flash[:notice] = "User '#{@user.username}' deleted."
    rescue StandardError => e
      flash[:notice] = e.message
    end
      respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end
end
