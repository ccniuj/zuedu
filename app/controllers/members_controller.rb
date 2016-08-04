class MembersController < ApplicationController
  def get_member
    render json: { foo: 'bar', member: current_member }
  end
end