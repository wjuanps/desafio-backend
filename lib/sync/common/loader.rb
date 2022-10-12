require 'sync/common/loader_error'
require 'sync/csv_data/validator'

module Sync
  module Common
    class Loader
      def initialize
        @validator = Sync::CSV_DATA::Validator.new
      end

      def load_deputies(deputies)
        raise LoaderError, 'Array of deputies can\'t be empty' unless deputies.present? && deputies.count.positive?

        loader_errors = []
        deputies.each do |deputy|
          ActiveRecord::Base.transaction do
            @validator.create_or_update_deputy!(deputy)
            @validator.create_or_update_legislature!(deputy[:legislature])
            @validator.create_or_update_quota!(deputy[:quota])
            @validator.create_or_update_provider!(deputy[:provider])
            @validator.create_or_update_invoice!(deputy[:invoice])
          end
        end

        loader_errors
      end
    end
  end
end
