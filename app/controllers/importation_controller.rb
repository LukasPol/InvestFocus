class ImportationController < ApplicationController
  def new
    @importation = Importation.new
  end

  def create
    @importation = current_user.importations.new(file_param)

    if @importation.save
      Imports::StartImportationWorker.perform_async(@importation.id)

      respond_to do |format|
        format.html { redirect_to tradings_path, notice: 'Importação iniciada' }
        format.turbo_stream { flash.now[:notice] = 'Importação iniciada.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def file_param
    params.require(:importation).permit(:file)
  end
end
