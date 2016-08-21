class MemberMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email(member)
    @member = member
    @url  = 'http://example.com/login'
    mail(to: @member.email, subject: 'Welcome to My Awesome Site')
  end
end
