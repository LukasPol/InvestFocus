class ImporterController < ApplicationController
  def new
    @importer = Importer.new
  end

  def create
    @importer = current_user.importers.new(file_param)

    if @importer.save
      Imports::FromB3.call(@importer)
      @assets = current_user.assets
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
    params.require(:importer).permit(:file)
  end
end
