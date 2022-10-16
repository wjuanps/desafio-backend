
require 'rails_helper'

RSpec.describe StateHelper do
  describe '#month_name_from_month_code' do
    let(:state_code) { 'PA' }

    context 'When state code is invalid' do
      it 'returns nil' do
        expect(StateHelper.state_name_from_state_code('PS')).to be_nil
      end
    end

    context 'Convert state name from state code' do
      let(:expected_state) { 'Pará' }

      it 'returns Pará' do
        expect(StateHelper.state_name_from_state_code(state_code)).to eq(expected_state)
      end
    end
  end
end
