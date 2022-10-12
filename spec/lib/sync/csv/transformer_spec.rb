require 'rails_helper'
require 'sync/csv_data/transformer'

RSpec.describe Sync::CSV_DATA::Transformer do
  subject(:transaform) { described_class.new }

  describe 'Transform data from csv to deputy object' do
    context 'when the csv_data is empty' do
      let(:csv_data) { [] }

      it 'should return nil' do
        data = transaform.transform_csv_to_deputy_objects(csv_data)
        expect(data).to be_nil
      end
    end

    context 'with valid value' do
      let(:csv_data) do
        [
          {
            deputy_identifier: '74075',
            name: 'Elcione Barbalho',
            taxpayer: '605387249',
            parliamentary_card: '21',
            legislature_number: '2019',
            state: 'PA',
            political_party: 'MDB',
            legislature_code: '56',
            sub_quota_number: '1',
            description: 'MANUTENÇÃO DE ESCRITÓRIO DE APOIO À ATIVIDADE PARLAMENTAR',
            sub_quota_esoecification_number: '0',
            description_especification: nil,
            provider_name: 'ARUAN DO CARMO',
            provider_identifier: '006.265.702/04 -',
            document_number: '7157876',
            document_type: '1',
            issue_date: '2021-02-12 0:00:00',
            document_value: '1200',
            gross_value: '0',
            net_value: '1200',
            month: '1',
            year: '2021',
            installments: '0',
            passenger_name: nil,
            leg_trip: nil,
            batch: '1747065',
            refund: nil,
            restitution: nil,
            requester_id: '1011',
            document_url: 'https://www.camara.leg.br/cota-parlamentar/documentos/publ/1011/2021/7157876.pdf'
          }
        ]
      end

      let(:expected_deputy) do
        {
          deputy_identifier: 74075,
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
            document_number: 7157876,
            document_type: 1,
            issue_date: Time.new('2021-02-12 0:00:00'),
            document_value: 120000,
            gross_value: 0,
            net_value: 120000,
            month: 1,
            year: 2021,
            installments: 0,
            passenger_name: nil,
            leg_trip: nil,
            batch: 1747065,
            refund: nil,
            restitution: nil,
            requester_id: 1011,
            document_url: 'https://www.camara.leg.br/cota-parlamentar/documentos/publ/1011/2021/7157876.pdf'
          },
          provider: {
            provider_name: 'ARUAN DO CARMO',
            provider_identifier: '006.265.702/04 -'
          }
        }
      end

      it 'translates to expected format' do
        transformed = transaform.transform_csv_to_deputy_objects(csv_data)

        expect(transformed.first).to eql(expected_deputy)
      end
    end
  end
end
