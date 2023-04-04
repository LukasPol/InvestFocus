module Imports
  class StartImportationWorker
    include Sidekiq::Job

    sidekiq_options queue: :highest, retry: 4

    def perform(import_id)
      @import = Importer.find(import_id)

      Imports::FromB3.call(@import)
    end
  end
end
