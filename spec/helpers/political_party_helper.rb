
require 'rails_helper'

RSpec.describe PoliticalPartyHelper do
  describe '#month_name_from_month_code' do
    let(:political_party) { 'PV' }

    context 'When political party is invalid' do
      it 'returns nil' do
        expect(PoliticalPartyHelper.political_party_name_from_political_party_code('PS')).to be_nil
      end
    end

    context 'Convert political party name from political party code' do
      let(:expected_political_party) { 'PARTIDO VERDE' }

      it 'returns PARTIDO VERDE' do
        expect(PoliticalPartyHelper.political_party_name_from_political_party_code(political_party)).to eq(expected_political_party)
      end
    end
  end
end
