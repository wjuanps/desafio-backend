# frozen_string_literal: true

require 'rails_helper'
require 'sync/csv_data/extractor'

RSpec.describe Sync::CSVData::Extractor do
  subject(:extractor) { described_class.new }

  describe 'Extract data from CSV file' do
    context 'with invalid filename' do
      let(:filename) { '/tmp/test.csv' }

      it 'should return nil' do
        data = extractor.extract_data_from_csv(filename)
        expect(data).to be_nil
      end
    end

    context 'with valid filename' do
      let(:csv) do
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
            document_number: '27',
            document_type: '1',
            issue_date: '2021-02-12T00:00:00',
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
      let(:filename) { 'lib/tasks/seed/seed_files/csv/test.csv' }

      it 'returns response' do
        data = extractor.extract_data_from_csv(filename)
        expect(data.count).to eql(1)
        expect(data[0][:deputy_identifier]).to eql('74075')
      end
    end
  end
end
