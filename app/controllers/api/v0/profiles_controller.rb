class Api::V0::ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!

  respond_to :json

  def me
    render json: current_resource_owner
  end

  def index
  render json: User.select(:id, :email, :first_name, :last_name).all_except(current_resource_owner)
  end

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end
