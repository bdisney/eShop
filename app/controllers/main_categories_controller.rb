class MainCategoriesController < ApplicationController
  before_action :set_main_category, only: [:show, :edit, :update, :destroy]

  # GET /main_categories
  # GET /main_categories.json
  def index
    @main_categories = MainCategory.all
  end

  # GET /main_categories/1
  # GET /main_categories/1.json
  def show
  end

  # GET /main_categories/new
  def new
    @main_category = MainCategory.new
  end

  # GET /main_categories/1/edit
  def edit
  end

  # POST /main_categories
  # POST /main_categories.json
  def create
    @main_category = MainCategory.new(main_category_params)

    respond_to do |format|
      if @main_category.save
        format.html { redirect_to @main_category, notice: 'Main category was successfully created.' }
        format.json { render :show, status: :created, location: @main_category }
      else
        format.html { render :new }
        format.json { render json: @main_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /main_categories/1
  # PATCH/PUT /main_categories/1.json
  def update
    respond_to do |format|
      if @main_category.update(main_category_params)
        format.html { redirect_to @main_category, notice: 'Main category was successfully updated.' }
        format.json { render :show, status: :ok, location: @main_category }
      else
        format.html { render :edit }
        format.json { render json: @main_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_categories/1
  # DELETE /main_categories/1.json
  def destroy
    @main_category.destroy
    respond_to do |format|
      format.html { redirect_to main_categories_url, notice: 'Main category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_category
      @main_category = MainCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_category_params
      params.require(:main_category).permit(:name, :description)
    end
end
