class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js
  include CurrentCart
  before_action :set_cart
  skip_authorization_check
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create

    super
    if @user.persisted?
      UserMailer.welcome(@user).deliver
    end 
    current_or_guest_user

   end

  # GET /resource/edit
  def edit
     super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  
  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, )
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
   end

  # The path used after sign up.
  

  def after_sign_up_path_for(resource)
    store_path(resource)
end

  def after_update_path_for(resource)
       user_path(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
