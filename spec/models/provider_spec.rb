require 'rails_helper'

RSpec.describe Provider do
  let(:provider) { create(:provider) }

  describe 'validations' do
    context 'when name and provider_identifier are all missing' do
      before do
        provider.name = nil
      end

      it 'is invalid' do
        expect(provider.valid?).to be(false)
      end
    end
    
    context 'when name and provider_identifier are all present' do
      before do
        provider.name = "Ruan Soares"
        provider.provider_identifier = 743543416354635
      end

      it 'is valid' do
        expect(provider.valid?).to be(true)
      end
    end
  end

  describe 'associations' do
    context 'has_many :legislatures' do
      let(:deputy) { create(:deputy) }
      let!(:legislature) { create(:legislature, deputy: deputy) }
      let!(:deputy_quota) { create(:deputy_quotum, legislature: legislature) }
      let!(:invoice) { create(:invoice, deputy_quotum: deputy_quota, deputy: deputy, provider: provider) }
      let!(:other_invoice) { create(:invoice, deputy_quotum: deputy_quota, deputy: deputy, provider: provider) }
      
      it 'should have legislatures' do
        expect(provider.invoices.count).to eq(2)
        expect(provider.invoices).to include(invoice)
        expect(provider.invoices).to include(other_invoice)
      end
    end
  end
end
