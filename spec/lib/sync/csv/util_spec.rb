require 'rails_helper'
require 'date'
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
      let(:value_converted) { 'R$ 500.058,00' }

      it 'should return value converted' do
        data = util.convert_cents_to_real(value)
        expect(data).to eql(value_converted)
      end
    end
  end

  describe 'Format issue_date' do
    context 'when issue_date, month and year are all missing' do
      it 'should raise invalid date' do
        data = util.format_issue_date(nil, nil, nil)
        expect(data).to be_falsy
      end
    end

    context 'when issue_date, month and year are all present' do
      let(:issue_date) { '2021-02-12T00:00:00' } 

      it 'should raise invalid date' do
        data = util.format_issue_date(issue_date, 2021, 10)
        expect(data).to_not be_falsy
      end
    end
  end
end
