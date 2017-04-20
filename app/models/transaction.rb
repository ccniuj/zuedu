class Transaction < ActiveRecord::Base
  belongs_to :order
  after_initialize :generate_trade_number
  validate :check_trade_number, :check_mac_value, on: :update
  after_update :check_pay
  def to_param
    trade_number
  end

private

  def generate_trade_number
    self.trade_number = SecureRandom.hex(3) if trade_number.nil?
  end

  def check_trade_number
    errors.add(:params, 'wrong trade number') unless params['MerchantTradeNo'] == trade_number
  end

  def check_mac_value
    errors.add(:params, 'wrong mac value') unless Allpay.client.verify_mac(params)
  end
  def check_pay
    logger.info(params["RtnCode"])
    if params["RtnCode"]=="1"
      logger.info "PAY"
      send_pay_success_email! self
    elsif params["RtnCode"]=="10100073"
      logger.info "CVSSS"
      send_cvs_info_email! self
    elsif params["RtnCode"]=="2"
      logger.info "ATMM"
      send_atm_info_email! self
    else
      logger.info "error"
    end
  end
  def send_pay_success_email! transaction
    transaction.order.line_items.each do |applicant|
      MemberMailer.payment_success(applicant).deliver_now#remember change it to the deliver_later
    end
  end
  def send_atm_info_email! transaction
    @params=transaction.params
    @email=transaction.order.line_items.parent_email
    logger.info "params #{@params} ,email #{@email}"
    MemberMailer.atm_info(@params,@email).deliver_now#remember change it to the deliver_later
  end
  def send_cvs_info_email! transaction
    @params=transaction.params
    @email=transaction.order.line_items.parent_email
    logger.info "params #{@params} ,email #{@email}"
    MemberMailer.cvs_info(@params,@email).deliver_now #remember change it to the deliver_later
  end
end