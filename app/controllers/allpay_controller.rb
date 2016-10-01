class AllpayController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :callback
  # post /allpay/form/:order_id
  def form
    order = Order.find params[:order_id]
    transaction = CartService.create_transaction_from_order order
    @params = Allpay::Form.new(transaction, 
      ClientBackURL: "#{APP_CONFIG['domain_front']}/orders/show/#{order.id}",
      ChoosePayment: order.payment
    ).params
    render json: { payload: @params, url: "#{Allpay.client.api_host}/Cashier/AioCheckOut/V2" }
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "查無訂單編號 ##{params[:order_id]}"
  rescue CartService::OrderIsPaid
    redirect_to order, alert: "訂單 ##{order.id} 已經付款了"
  end

  # post /allpay/callback
  def callback
    transaction = Transaction.find_by!(trade_number: params[:MerchantTradeNo])
    transaction.update!(params: request.POST)
    MemberMailer.payment_notification(transaction.order.member, transaction).deliver_later
    render text: :'1|OK'
  rescue ActiveRecord::RecordNotFound
    render text: :'0|transaction record not found'
  rescue ActiveRecord::RecordNotSaved
    render text: :'0|transaction not saved'
  rescue
    render text: "0|#{$!}"
  end
end
