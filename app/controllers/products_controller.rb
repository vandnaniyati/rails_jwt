class ProductsController < ApplicationController
  before_action :set_product, except: %i[ create index ]

  # GET /products
  def index
    if params[:search_name].present?
      @products = Product.where("name LIKE ?", "%#{params[:search_name]}%").paginate(page: params[:page])
    else
      @products = Product.paginate(page: params[:page])
    end
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    # @product = @current_user.products.new(product_params)
    @product = Product.new(product_params)
     
    if @product.save
      # ProductMailer.product_created(@current_user).deliver_now
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    puts @current_user.email
    puts "======================================>>>>>>"
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price)
      #params.permit(:name, :price)
    end
end

