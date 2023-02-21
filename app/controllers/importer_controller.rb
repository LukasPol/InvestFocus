class ImporterController < ApplicationController
  def new
    @importer = Importer.new
  end

  def create
    @importer = Importer.create(file_param)
    Tradings::CreateWithFile.call(params[:importer][:file], current_user)
    redirect_to tradings_path, notice: 'Importação iniciada'
  end

  private

  def file_param
    params.require(:importer).permit(:file)
  end
end
