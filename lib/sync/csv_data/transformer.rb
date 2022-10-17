require_relative 'util'

module Sync
  module CSVData
    class Transformer

      def initialize
        @util = Util.new
      end

      def transform_csv_to_deputy_objects(csv_data)
        return nil unless csv_data.present? && csv_data.count.positive?

        deputies = []
        csv_data.each do |csv|
          deputies << {
            deputy_identifier: csv[:deputy_identifier].to_i,
            name: csv[:name],
            taxpayer: csv[:taxpayer],
            legislature: legislature_data(csv),
            quota: deputy_quota_data(csv),
            invoice: invoice_data(csv),
            provider: provider_data(csv)
          }
        end

        deputies.compact
      end

      def legislature_data(csv)
        {
          parliamentary_card: csv[:parliamentary_card].to_i,
          legislature_number: csv[:legislature_number].to_i,
          state: csv[:state],
          political_party: csv[:political_party],
          legislature_code: csv[:legislature_code].to_i
        }.freeze
      end

      def deputy_quota_data(csv)
        {
          sub_quota_number: csv[:sub_quota_number].to_i,
          description: csv[:description],
          sub_quota_specification_number: csv[:sub_quota_specification_number].to_i,
          description_specification: csv[:description_specification]
        }.freeze
      end

      def provider_data(csv)
        {
          provider_name: csv[:provider_name],
          provider_identifier: csv[:provider_identifier].present? ? csv[:provider_identifier] : csv[:provider_name]
        }.freeze
      end

      # rubocop:disable Metrics/AbcSize
      def invoice_data(csv)
        {
          document_number: csv[:document_number].to_i,
          document_type: csv[:document_type].to_i,
          issue_date: @util.format_issue_date(csv[:issue_date], csv[:year], csv[:month]),
          document_value: csv[:document_value],
          gross_value: csv[:gross_value],
          net_value: csv[:net_value],
          month: csv[:month].to_i,
          year: csv[:year].to_i,
          installments: csv[:installments].to_i,
          passenger_name: csv[:passenger_name],
          leg_trip: csv[:leg_trip],
          batch: csv[:batch].to_i,
          refund: csv[:refund],
          restitution: csv[:restitution],
          requester_id: csv[:requester_id].to_i,
          document_url: csv[:document_url]
        }.freeze
      end
      # rubocop:enable Metrics/AbcSize

    end
  end
end
