class MemberMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def greeting(member)
    @member = member
    mail(to: @member.email, subject: '恭喜您註冊成為築優教育的會員')
  end
end
