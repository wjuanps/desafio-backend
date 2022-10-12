module Sync
  module Common
    class LoaderError < StandardError
      def initialize(msg)
        super(msg)
      end
    end
  end
end
