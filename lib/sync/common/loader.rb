require_relative 'loader_error'
require_relative '../../../app/services/load/load_deputy'

module Sync
  module Common
    class Loader

      def load_deputies(deputies)
        raise LoaderError, 'Array of deputies can\'t be empty' unless deputies.present? && deputies.count.positive?

        loader_errors = []
        deputies.each do |deputy|
          ActiveRecord::Base.transaction do
            Services::Load::LoadDeputy.call!(deputy)
          end
        rescue ActiveRecord::RecordInvalid => e
          loader_errors << { message: e.message, deputy: deputy }
          next
        end

        loader_errors
      end

    end
  end
end
