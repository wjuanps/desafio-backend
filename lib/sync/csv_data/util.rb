# rubocop:disable Style/MixinUsage
include ActionView::Helpers::NumberHelper
# rubocop:enable Style/MixinUsage

module Sync
  module CSVData
    class Util

      def convert_real_to_cents(value)
        return 0 unless value.present?

        (value.to_f * 100).to_i
      end

      def convert_cents_to_real(value_cents)
        return 'R$ 0' unless value_cents.present? && value_cents.positive?

        number_to_currency_br(value_cents)
      end

      def format_issue_date(issue_date, year, month)
        issue_date.present? ? DateTime.iso8601(issue_date) : DateTime.new(year.to_i, month.to_i, 1)
      rescue StandardError
        false
      end

      def number_to_currency_br(number)
        number_to_currency(number, unit: 'R$ ', separator: ',', delimiter: '.', precision: 2)
      end

    end
  end
end
