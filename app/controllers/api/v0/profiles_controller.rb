# frozen_string_literal: true

class Api::V0::ProfilesController < Api::V0::BaseController
  def me
    render json: current_resource_owner
  end

  def index
    render json: User.select(:id, :email, :first_name, :last_name).all_except(current_resource_owner)
  end
end
