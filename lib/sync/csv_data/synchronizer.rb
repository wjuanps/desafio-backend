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

      def sync(filename)
        sync_csv_file(filename)
      end

      def sync_csv_file(filename)
        data_from_csv = @extractor.extract_data_from_csv(filename)
        deputies = @transformer.transform_csv_to_deputy_objects(data_from_csv)
        @loader.load_deputies(deputies)
      end

    end
  end
end
