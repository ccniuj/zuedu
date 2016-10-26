class OrdersController < ApplicationController
  before_action :set_order, only: [ :show ]

  def index
    @orders = current_member.orders.all
    render json: @orders
  rescue NoMethodError
    render json: { message: '會員尚未登入' }, status: 401
  end

  def show
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
    params[:orders][:discount_id] = Discount.find_by_key!(params[:orders][:discount_key])&.id if params[:orders][:discount_key].present?
    @order = CartService.create_order_from_cart current_cart, order_params
    MemberMailer.payment_notification(current_member, @order).deliver_later
    redirect_to allpay_form_path(@order), status: 200
  rescue CartService::CartIsEmpty
    @order = Order.new order_params
    render json: { message: '購物車是空的' }, status: 422
  rescue ActiveRecord::RecordInvalid
    @order = Order.new order_params
    render json: { message: "#{$!}" }, status: 422
  rescue ActiveRecord::RecordNotFound
    @order = Order.new order_params
    render json: { message: '找不到折扣代碼，請重新輸入' }, status: 422
  end

private
  def set_order
    @order = Order.find params[:id]
  end

  def order_params
    params.require(:orders).permit(:first_name, :last_name, :email, :address, :payment, :discount_id)
  end
end