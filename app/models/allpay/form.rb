module Allpay
  class Form
    def initialize transaction, **overwrite_params
      @transaction, @overwrite_params = transaction, overwrite_params
    end

    def params
      Allpay.client.generate_checkout_params({
        MerchantTradeNo: @transaction.trade_number,
        TotalAmount: @transaction.order.price.to_i,
        TradeDesc: Settings.allpay.trade_desc,
        ItemName: item_name,
        ReturnURL: Settings.allpay.return_url,
        PaymentInfoURL: Settings.allpay.return_url,
        ChoosePayment: 'Credit'
      }.merge!(@overwrite_params))
    end

    def item_name
      @transaction.order.line_items.includes(:product_detail).map{|i| "#{i.product_detail.product.name} x 1"}.join('#')
    end
  end
end
