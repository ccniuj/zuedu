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

  def callback
    transaction = Transaction.find_by!(trade_number: params[:MerchantTradeNo])
    transaction.update!(params: request.POST)
    puts transaction[:RtnCode]
    if transaction[:RtnCode]==1
      send_pay_success_email! transaction
    elsif transaction[:RtnCode]==10100073
      send_cvs_info_email! transaction
    elsif transaction[:RtnCode]==2
      send_atm_info_email! transaction
    end
    render text: :'1|OK'
  rescue ActiveRecord::RecordNotFound
    render text: :'0|transaction record not found'
  rescue ActiveRecord::RecordNotSaved
    render text: :'0|transaction not saved'
  rescue
    render text: "0|#{$!}"
  end

  private

  def send_pay_success_email! transaction
    transaction.order.line_items.each do |applicant|
      MemberMailer.payment_success(applicant).deliver_now
      #remember change it to the deliver_later
    end
  end
  def send_atm_info_email! transaction

    @params=transaction.params
    @email=transaction.order.line_items.parent_email
    logger.info "params #{@params} ,email #{email}"
      MemberMailer.atm_info(@params,@email).deliver_now
      #remember change it to the deliver_later
    end
  end
  def send_cvs_info_email! transaction
    @params=transaction.params
    @email=transaction.order.line_items.parent_email
    logger.info "params #{@params} ,email #{email}"
      MemberMailer.cvs_info(@params,@email).deliver_now
      #remember change it to the deliver_later
  end
end
