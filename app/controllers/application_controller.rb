class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: -> { request.format.symbol == :json }
  before_action :set_cart
  before_action :connect_cart_to_member

  def set_cart
    Rails.logger.debug "session cart_id: #{session[:cart_id]}"
    session[:cart_id] ||= Cart.create.id
  end

  def connect_cart_to_member
    if current_member && !current_cart.member
      current_cart.update member_id: current_member.id
    end
  end

  def current_cart
    Cart.find(session[:cart_id])
  end
end
