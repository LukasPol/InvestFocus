class TradingsController < ApplicationController
  def index
    @tradings = current_user.tradings
  end
end
