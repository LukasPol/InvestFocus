class ImporterController < ApplicationController
  def new
    @importer = Importer.new
  end

  def create
    @importer = Importer.create(file_param)
    Tradings::CreateWithFile.call(params[:importer][:file], current_user)
    @assets = current_user.assets
    respond_to do |format|
      format.html { redirect_to tradings_path, notice: 'Importação iniciada' }
      format.turbo_stream { flash.now[:notice] = 'Importação iniciada.' }
    end
  end

  private

  def file_param
    params.require(:importer).permit(:file)
  end
end
