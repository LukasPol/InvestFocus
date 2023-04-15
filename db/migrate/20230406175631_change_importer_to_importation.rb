class ChangeImporterToImportation < ActiveRecord::Migration[7.0]
  def change
    rename_table :importers, :importation
  end
end
