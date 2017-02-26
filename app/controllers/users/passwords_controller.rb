class Users::PasswordsController < Devise::PasswordsController
  
  include CurrentCart
  before_action :set_cart
   prepend_before_filter :require_no_authentication
  append_before_filter :assert_reset_token_passed, :only => :edit
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
   def create
     self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      redirect_to store_url, :notice => "Instruction has been send to your email"
    else
      respond_with(resource)
    end
   end

  # GET /resource/password/edit?reset_password_token=abcdef
   def edit
     super
   end

  # PUT /resource/password
   def update
     self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      redirect_to store_url, :notice => "Password has been change"
    else
      respond_with resource
    end
   end

   protected

   def after_resetting_password_path_for(resource)
     super(resource)
   end

  # The path used after sending reset password instructions
   def after_sending_reset_password_instructions_path_for(resource_name)
     store_url
   end

   def assert_reset_token_passed
      super
    end

    def unlockable?(resource)
      super
    end
end
