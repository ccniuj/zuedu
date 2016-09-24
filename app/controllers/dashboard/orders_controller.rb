class Dashboard::OrdersController < DashboardController
  before_action :set_order, only: [ :edit, :update, :destroy, :remind ]

  def index
    @orders = Order.all.sort
    render json: @orders
  end

  def edit
    render json: @order
  end

  def update
    if @order.update order_params
      render json: { message: '更新成功' }, status: :ok
    else
      render json: { message: '更新失敗' }, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    render json: { message: '刪除成功' }, status: :ok
  end

  def remind
    MemberMailer.payment_reminding(@order.member).deliver_later
    render json: { message: '通知成功' }, status: :ok
  end

  private
    def set_order
      @order = Order.find params[:id]
    end

    def order_params
      params.require(:orders).permit(:first_name, :last_name, :email)
    end
end