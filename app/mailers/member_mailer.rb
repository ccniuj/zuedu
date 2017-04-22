class MemberMailer < ApplicationMailer
  before_action :add_inline_attachment!
  default from: '清大ZU創意教學 <zubat.nthu@gmail.com>'
 
  def greeting(member)
    @member = member
    mail(to: @member.email, subject: 'ZU | 歡迎加入會員')
  end

  def payment_notification(member, order)
    @member = member
    @order = order

    mail(to: @member.email, subject: 'ZU | 繳費通知')
  end

  def payment_reminding(member)
    @member = member
    mail(to: @member.email, subject: 'ZU | 繳費最後通知')
  end

  def payment_success(applicant)
    @applicant = applicant
    mail(to: @applicant.parent_email, subject: 'ZU | 完成報名')
  end
  def atm_info(transaction)
    logger.info "123"
    @order =transaction.order
    logger.info "123"
    @params = transaction.params
    mail(to: @order.email, subject: 'ZU | ATM_INFO')
    logger.info "done"
  end
  def cvs_info(transaction)
    logger.info "123"
    @order =transaction.order
    logger.info "123"
    @params = transaction.params
    mail(to: @order.email, subject: 'ZU | CVS_INFO')
    logger.info "done"
  end
  private
  def add_inline_attachment!
    attachments.inline['logo.png'] = File.read('public/images/logo.png')
  end
end
