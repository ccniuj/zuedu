class Dashboard::DiscountsController < DashboardController
  before_action :set_discount, only: [:edit, :update, :destroy]

  def index
    @discounts = Discount.all.sort
    render json: @discounts
  end

  def edit
    render json: @discount
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      render json: { message: '新增成功' }, status: :created
    else
      render json: { message: @discount.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  def update
    if @discount.update discount_params
      render json: { message: '更新成功' }, status: :ok
    else
      render json: { message: @discount.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  def destroy
    @discount.destroy
    render json: { message: '刪除成功' }, status: :ok
  end

  private
    def set_discount
      @discount = Discount.find params[:id]
    end

    def discount_params
      params.require(:discounts).permit(:name, :prerequisite, :discount_type, :factor, :date_from, :date_to)
    end
end