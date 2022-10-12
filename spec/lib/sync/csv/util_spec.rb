require 'rails_helper'
require 'sync/csv_data/util'

RSpec.describe Sync::CSV_DATA::Util do
  subject(:util) { described_class.new }

  describe 'Convert real to cents' do
    context 'with invalid value' do
      let(:value) { nil }
      let(:value_converted) { 0 }

      it 'should return zero' do
        data = util.convert_real_to_cents(value)
        expect(data).to eql(value_converted)
      end
    end

    context 'with valid value' do
      let(:value) { '5000.58' }
      let(:value_converted) { 500058 }

      it 'should return value converted' do
        data = util.convert_real_to_cents(value)
        expect(data).to eql(value_converted)
      end
    end
  end

  describe 'Convert cents to real' do
    context 'with invalid value' do
      let(:value) { 0 }
      let(:value_converted) { 'R$ 0' }

      it 'should return zero' do
        data = util.convert_cents_to_real(value)
        expect(data).to eql(value_converted)
      end
    end

    context 'with valid value' do
      let(:value) { 500058 }
      let(:value_converted) { 'R$ 5000.58' }

      it 'should return value converted' do
        data = util.convert_cents_to_real(value)
        expect(data).to eql(value_converted)
      end
    end
  end
end
