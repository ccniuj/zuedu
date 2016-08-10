class MembersController < ApplicationController
  def get_member
    render json: { member: current_member }
  end
end