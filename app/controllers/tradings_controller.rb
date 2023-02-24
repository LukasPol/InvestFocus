class TradingsController < ApplicationController
  def index
    @search = current_user.tradings.ransack(params[:q])
    @tradings = @search.result
  end
end
