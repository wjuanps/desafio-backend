require 'sync/common/loader_error'

module Sync
  module CSV_DATA
    class Validator
      def create_or_update_deputy!(deputy)
        existing_deputy = Deputy.find_by(deputy_identifier: deputy[:deputy_identifier])

        if existing_deputy.nil?
          @deputy = Deputy.new(deputy_identifier: deputy[:deputy_identifier],
                               name: deputy[:name],
                               taxpayer: deputy[:taxpayer])
          @deputy.save!
        else
          @deputy = existing_deputy.update!(deputy_identifier: deputy[:deputy_identifier],
                                            name: deputy[:name],
                                            taxpayer: deputy[:taxpayer])
        end

        @deputy
      end

      def create_or_update_legislature!(legislature)
        existing_legislature = Legislature.find_by(legislature_number: legislature[:legislature_number],
                                                    deputy_id: @deputy.id)
        if existing_legislature.nil?
          @legislature = Legislature.new(deputy_id: @deputy.id,
                                          legislature_number: legislature[:legislature_number],
                                          legislature_code: legislature[:legislature_code],
                                          parliamentary_card: legislature[:parliamentary_card],
                                          state: legislature[:state],
                                          political_party: legislature[:political_party])
          @legislature.save!
        else
          @legislature = Legislature.update!(legislature_number: legislature[:legislature_number],
                                              legislature_code: legislature[:legislature_code],
                                              parliamentary_card: legislature[:parliamentary_card],
                                              state: legislature[:state],
                                              political_party: legislature[:political_party])
        end

        @legislature
      end

      def create_or_update_quota!(quota)
        existing_quota = Quota.find_by(sub_quota_number: quota[:sub_quota_number],
                                       legislature_id: @legislature.id)
        if existing_quota.nil?
          @quota = Quota.new(legislature_id: @legislature.id,
                             sub_quota_number: quota[:sub_quota_number],
                             description: quota[:description],
                             sub_quota_esoecification_number: quota[:sub_quota_esoecification_number],
                             description_especification: quota[:description_especification])
          @quota.save!
        else
          @quota = Quota.update!(legislature_id: @legislature.id,
                                 sub_quota_number: quota[:sub_quota_number],
                                 description: quota[:description],
                                 sub_quota_esoecification_number: quota[:sub_quota_esoecification_number],
                                 description_especification: quota[:description_especification])
        end

        @quota
      end

      def create_or_update_provider!(provider)
        existing_provider = Provider.find_by(provider_identifier: provider[:provider_identifier])
        if existing_provider.nil?
          @provider = Provider.new(name: provider[:provider_name], provider_identifier: provider[:provider_identifier])
          @provider.save!
        else
          @provider = Provider.update!(name: provider[:provider_name])
        end

        @provider
      end

      def create_or_update_invoice!(invoice)
        existing_invoice = Invoice.find_by(document_number: invoice[:document_number],
                                           quota_id: @quota.id,
                                           provider_id: @provider.id)
        if existing_invoice.nil?
          @invoice = Invoice.new(quota_id: @quota.id,
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
        else
          @invoice = Invoice.update!(document_type: invoice[:document_type],
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
        end

        @invoice
      end
    end
  end
end
