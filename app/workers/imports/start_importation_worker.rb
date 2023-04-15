module Imports
  class StartImportationWorker
    include Sidekiq::Job

    sidekiq_options queue: :highest, retry: 4

    def perform(import_id)
      @importation = Importation.find(import_id)

      Imports::FromB3.call(@importation)
    end
  end
end
