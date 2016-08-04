class OrdersController < ApplicationController
  def index
    @orders = current_cart.orders.all
    render json: @orders
  end

  def show
    @order = Order.find params[:id]
    render json: @order
  end

  def new
    if current_cart.empty?
      render json: { message: '購物車是空的' }
    else
      @order = Order.new
      render json: @order
    end
  end

  def create
    @order = CartService.create_order_from_cart current_cart, order_params
    redirect_to allpay_form_path(@order), status: 200
    # redirect_to controller: 'allpay', action: 'form', order_id: @order.id, status: 200
    # head 200, location: allpay_form_path(@order)
  rescue CartService::CartIsEmpty
    @order = Order.new order_params
    render json: { message: '購物車是空的' }
  rescue ActiveRecord::ActiveRecordError
    @order = Order.new order_params
    render json: { message: "出錯了：#{$!}" }
  end

private

  def order_params
    params.require(:orders).permit(:first_name, :last_name, :email, :address)
  end
end