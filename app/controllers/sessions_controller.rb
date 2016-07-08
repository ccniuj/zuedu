class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, if: -> { request.format.symbol == :json }
end