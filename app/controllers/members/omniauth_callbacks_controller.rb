class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook

    @member = Member.from_omniauth(request.env["omniauth.auth"])
    if @member.persisted?
      sign_in @member, :event => :authentication #this will throw if @member is not activated

      redirect_to "#{APP_CONFIG['domain_front']}#{request.env['omniauth.params']['redirect_url']}"
    else
      binding.pry
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_member_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end