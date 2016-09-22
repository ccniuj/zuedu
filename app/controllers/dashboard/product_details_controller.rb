class Dashboard::ProductDetailsController < DashboardController
  before_action :set_product_detail, only: [:edit, :update, :destroy]

  def index
    @product_details = ProductDetail.all.sort
    render json: @product_details
  end

  def edit
    render json: @product_detail
  end

  def create
    @product_detail = ProductDetail.new(product_detail_params)
    if @product_detail.save
      render json: { message: '新增成功' }, status: :created
    else
      render json: { message: '新增失敗' }, status: :unprocessable_entity
    end
  end

  def update
    if @product_detail.update product_detail_params
      render json: { message: '更新成功' }, status: :ok
    else
      render json: { message: '更新失敗' }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_detail.destroy
    render json: { message: '刪除成功' }, status: :ok
  end

  private
    def set_product_detail
      @product_detail = ProductDetail.find params[:id]
    end

    def product_detail_params
      params.require(:product_details).permit(:product_id, :description, :from, :to)
    end
end