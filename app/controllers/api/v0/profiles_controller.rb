class Api::V0::ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!

  def me
    render json: :nothing
  end
end
