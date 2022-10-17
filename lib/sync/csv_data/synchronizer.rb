require_relative '../common/loader'
require_relative '../common/loader_error'
require_relative 'extractor'
require_relative 'transformer'

module Sync
  module CSVData
    class Synchronizer

      def initialize
        @extractor = Extractor.new
        @transformer = Transformer.new
        @loader = Sync::Common::Loader.new
      end

      def sync(file)
        sync_csv_file(file)

        { error: false, message: 'Deputados cadastrados com sucesso!!' }
      rescue StandardError, LoadError => e
        { error: true, message: e.message }
      end

      def sync_csv_file(file)
        data_from_csv = @extractor.extract_data_from_csv(file)
        deputies = @transformer.transform_csv_to_deputy_objects(data_from_csv)
        @loader.load_deputies!(deputies)
      rescue StandardError, LoadError => e
        raise e
      end

    end
  end
end
