class ProceedsController < ApplicationController
  def index
    @proceeds = current_user.proceeds.all
  end

  def new
    @proceed = Proceed.new
  end

  def create
    @proceed = current_user.proceeds.new(proceed_params)

    if @proceed.save
      respond_to do |format|
        format.html { redirect_to proceeds_url, notice: 'Criado com sucesso', status: :created }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def proceed_params
    params.require(:proceed).permit(:amount, :value_unit, :total_value, :date, :kind, :stock_id)
  end
end
