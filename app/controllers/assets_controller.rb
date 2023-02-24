class AssetsController < ApplicationController
  def index
    @search = current_user.assets.ransack(params[:q])
    @assets = @search.result
  end
end
