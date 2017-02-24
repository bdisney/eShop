class ContactsController < ApplicationController
  include CurrentCart
  load_and_authorize_resource
  before_action :set_cart

  before_action :set_contact, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.order('created_at desc')
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    redirect_to contacts_url, notice: 'Sorry, you cant edit existing contacts.' 
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save

        ContactMailer.received(@contact).deliver

        format.html { redirect_to store_url, notice: 'Thank you for your message!' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.js {flash.now[:notice] = "Here is my flash notice" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:email, :message, :name, :subject)
    end
end
