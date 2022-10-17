require 'rails_helper'
require 'sync/common/loader_error'
require 'sync/common/loader'

RSpec.describe Sync::Common::Loader do
  subject(:loader) { described_class.new }

  describe 'Load the deputies data into the database' do
    context 'when the array of deputies is empty' do
      let(:deputies) { [] }

      it 'should raise an loading error' do
        expect do
          loader.load_deputies(deputies)
        end.to raise_error(Sync::Common::LoaderError, 'Array of deputies can\'t be empty')
      end
    end

    context 'with valid value' do
      let(:deputies) do
        [{
          deputy_identifier: 74_075,
          name: 'Elcione Barbalho',
          taxpayer: '605387249',
          legislature: {
            parliamentary_card: 21,
            legislature_number: 2019,
            state: 'PA',
            political_party: 'MDB',
            legislature_code: 56
          },
          quota: {
            sub_quota_number: 1,
            description: 'MANUTENÇÃO DE ESCRITÓRIO DE APOIO À ATIVIDADE PARLAMENTAR',
            sub_quota_esoecification_number: 0,
            description_especification: nil
          },
          invoice: {
            document_number: 7_157_876,
            document_type: 1,
            issue_date: Time.new('2021-02-12 0:00:00'),
            document_value: 120_000,
            gross_value: 0,
            net_value: 120_000,
            month: 1,
            year: 2021,
            installments: 0,
            passenger_name: nil,
            leg_trip: nil,
            batch: 1_747_065,
            refund: nil,
            restitution: nil,
            requester_id: 1011,
            document_url: 'https://www.camara.leg.br/cota-parlamentar/documentos/publ/1011/2021/7157876.pdf'
          },
          provider: {
            provider_name: 'ARUAN DO CARMO',
            provider_identifier: '006.265.702/04 -'
          }
        }]
      end

      it 'should not raise error' do
        data = loader.load_deputies(deputies)

        expect { data }.not_to raise_error
      end
    end
  end
end
