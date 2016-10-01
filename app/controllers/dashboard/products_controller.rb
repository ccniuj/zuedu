class Dashboard::ProductsController < DashboardController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.all.sort
    render json: @products
  end

  def edit
    render json: @product
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: { message: '新增成功' }, status: :created
    else
      render json: { message: '新增失敗' }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update product_params
      render json: { message: '更新成功' }, status: :ok
    else
      render json: { message: '更新失敗' }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    render json: { message: '刪除成功' }, status: :ok
  end

  private
    def set_product
      @product = Product.find params[:id]
    end

    def product_params
      params.require(:products).permit(:name, :subtitle, :description, :dimension, :target, :pricing, :cover_image_url, :outline_image_url, :dimension_image_url)
    end
end