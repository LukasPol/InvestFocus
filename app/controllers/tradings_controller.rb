class TradingsController < ApplicationController
  def index
    @search = current_user.tradings.ransack(params[:q])
    @tradings = @search.result
  end

  def new
    @trading = Trading.new
  end

  def create
    @trading = current_user.tradings.new(trading_param)

    if @trading.save
      respond_to do |format|
        format.html { redirect_to tradings_url, notice: 'Criado com sucesso', status: :created }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def trading_param
    params.require(:trading).permit(:amount, :value_unit, :total_value, :date, :kind, :stock_code, :operation_cost)
  end
end
