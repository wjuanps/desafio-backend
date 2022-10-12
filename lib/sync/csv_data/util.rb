module Sync
  module CSV_DATA
    class Util
      def convert_real_to_cents(value)
        return 0 unless value.present?

        (value.to_f * 100).to_i
      end

      def convert_cents_to_real(value_cents)
        return 'R$ 0' unless value_cents.present? && value_cents.positive?

        "R$ #{format('%.2f', (value_cents.to_f / 100))}"
      end
    end
  end
end
