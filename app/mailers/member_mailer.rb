class MemberMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def greeting(member)
    @member = member
    mail(to: @member.email, subject: '恭喜您註冊成為築優教育的會員')
  end

  def add_to_cart_notification(member)
    @member = member
    mail(to: @member.email, subject: '您已在築優教育註冊一門課程')
  end

  def applicant_confirmation(member, line_item)
    @member = member
    @line_item = line_item
    mail(to: @member.email, subject: '您已更新報名資訊')
  end

  def payment_notification(member, transaction)
    @member = member
    @transaction = transaction
    mail(to: @member.email, subject: '恭喜您付款成功')
  end
end
