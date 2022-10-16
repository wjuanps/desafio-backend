
require 'rails_helper'

RSpec.describe MonthHelper do
  describe '#month_name_from_month_code' do
    let(:month_code) { 11 }

    context 'When month code is invalid' do
      it 'returns nil' do
        expect(MonthHelper.month_name_from_month_code(15)).to be_nil
      end
    end

    context 'Convert month name from month code' do
      let(:expected_month) { 'Novembro' }

      it 'returns Novembro' do
        expect(MonthHelper.month_name_from_month_code(month_code)).to eq(expected_month)
      end
    end
  end
end
