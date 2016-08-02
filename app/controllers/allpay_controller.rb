class AllpayController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :callback
  # post /allpay/form/:order_id
  def form
    order = Order.find params[:order_id]
    transaction = CartService.create_transaction_from_order order
    @params = Allpay::Form.new(transaction, ClientBackURL: "#{APP_CONFIG['domain_front']}/orders/show/#{order.id}").params
    render json: { payload: @params, url: "#{Allpay.client.api_host}/Cashier/AioCheckOut/V2" }    
    
    # uri = URI "#{Allpay.client.api_host}/Cashier/AioCheckOut"
    # req = Net::HTTP::Post.new uri
    # req['Content-Type'] = 'text/html'
    # req.set_form_data(@params.to_json)

    # req.body = @params.to_json

    # res = Net::HTTP.post_form uri, @params

    # http = Net::HTTP.new uri.hostname, uri.port
    # res = http.start { http.request req }
    
    # case res
    # when Net::HTTPSuccess, Net::HTTPRedirection
    #   res
    #   render json: { html: res.body.force_encoding("utf-8") }
    # else
    #   render json: { error: res.value }
    # end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "查無訂單編號 ##{params[:order_id]}"
  rescue CartService::OrderIsPaid
    redirect_to order, alert: "訂單 ##{order.id} 已經付款了"
  end

  # post /allpay/callback
  def callback
    Transaction.find_by!(trade_number: params[:MerchantTradeNo]).update!(params: request.POST)
    render text: :'1|OK'
  rescue ActiveRecord::RecordNotFound
    render text: :'0|transaction record not found'
  rescue ActiveRecord::RecordNotSaved
    render text: :'0|transaction not saved'
  rescue
    render text: "0|#{$!}"
  end
end
