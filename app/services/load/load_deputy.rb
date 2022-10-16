module Services
  module Load
    class LoadDeputy

      def self.call!(deputy)
        create_deputy!(deputy)
        create_legislature!(deputy[:legislature])
        create_deputy_quota!(deputy[:quota])
        create_provider!(deputy[:provider])
        create_invoice!(deputy[:invoice])
      end

      private

      def self.create_deputy!(deputy)
        @deputy = Deputy.find_by(deputy_identifier: deputy[:deputy_identifier])
        return @deputy unless @deputy.nil?

        begin
          @deputy = Deputy.new(deputy_identifier: deputy[:deputy_identifier],
                               name: deputy[:name],
                               taxpayer: deputy[:taxpayer])

          @deputy.save!
        rescue => exception
          raise exception
        end

        @deputy
      end

      def self.create_legislature!(legislature)
        @legislature = Legislature.find_by(legislature_number: legislature[:legislature_number],
                                           deputy_id: @deputy.id)
        return @legislature unless @legislature.nil?

        begin
          @legislature = Legislature.new(deputy_id: @deputy.id,
                                         legislature_number: legislature[:legislature_number],
                                         legislature_code: legislature[:legislature_code],
                                         parliamentary_card: legislature[:parliamentary_card],
                                         state: legislature[:state],
                                         political_party: legislature[:political_party])

          @legislature.save!
        rescue => exception
          raise exception
        end

        @legislature
      end

      def self.create_deputy_quota!(deputy_quota)
        @deputy_quota = DeputyQuotum.find_by(sub_quota_number: deputy_quota[:sub_quota_number],
                                             legislature_id: @legislature.id)
        return @deputy_quota unless @deputy_quota.nil?

        begin
          @deputy_quota = DeputyQuotum.new(legislature_id: @legislature.id,
                                           sub_quota_number: deputy_quota[:sub_quota_number],
                                           description: deputy_quota[:description],
                                           sub_quota_specification_number: deputy_quota[:sub_quota_specification_number],
                                           description_specification: deputy_quota[:description_specification])

          @deputy_quota.save!
        rescue => exception
          raise exception
        end

        @deputy_quota
      end

      def self.create_provider!(provider)
        @provider = Provider.find_by(provider_identifier: provider[:provider_identifier])
        return @provider unless @provider.nil?

        begin
          @provider = Provider.new(name: provider[:provider_name], provider_identifier: provider[:provider_identifier])

          @provider.save!
        rescue => exception
          raise exception
        end

        @provider
      end

      def self.create_invoice!(invoice)
        @invoice = Invoice.find_by(document_number: invoice[:document_number],
                                   deputy_id: @deputy.id,
                                   deputy_quota_id: @deputy_quota.id,
                                   provider_id: @provider.id)
        return @invoice unless @invoice.nil?

        begin
          @invoice = Invoice.new(deputy_id: @deputy.id,
                                 deputy_quota_id: @deputy_quota.id,
                                 provider_id: @provider.id,
                                 document_number: invoice[:document_number],
                                 document_type: invoice[:document_type],
                                 issue_date: invoice[:issue_date],
                                 document_value: invoice[:document_value],
                                 gross_value: invoice[:gross_value],
                                 net_value: invoice[:net_value],
                                 year: invoice[:year],
                                 month: invoice[:month],
                                 installments: invoice[:installments],
                                 passenger_name: invoice[:passenger_name],
                                 leg_trip: invoice[:leg_trip],
                                 batch: invoice[:batch],
                                 refund: invoice[:refund],
                                 restitution: invoice[:restitution],
                                 document_url: invoice[:document_url],
                                 requester_id: invoice[:requester_id])

          @invoice.save!
        rescue => exception
          raise exception
        end

        @invoice
      end
    end
  end
end
