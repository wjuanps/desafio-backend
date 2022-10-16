require 'rails_helper'

RSpec.describe Deputy do
  let(:deputy) { create(:deputy) }

  describe 'validations' do
    context 'when name, deputy_identifier, and taxpayer are all missing' do
      before do
        deputy.name = nil
      end

      it 'is invalid' do
        expect(deputy.valid?).to be(false)
      end
    end
    
    context 'when name, deputy_identifier, and taxpayer are all present' do
      before do
        deputy.name = "Ruan Soares"
        deputy.deputy_identifier = 743543416354635
        deputy.taxpayer = "553.006.780-82"
      end

      it 'is valid' do
        expect(deputy.valid?).to be(true)
      end
    end
  end

  describe 'associations' do
    context 'has_many :legislatures' do
      let!(:legislature) { create(:legislature, deputy: deputy) }
      let!(:other_legislature) { create(:legislature, deputy: deputy) }
      
      it 'should have legislatures' do
        expect(deputy.legislatures.count).to eq(2)
        expect(deputy.legislatures).to include(legislature)
        expect(deputy.legislatures).to include(other_legislature)
      end
    end

    context 'has_many :invoices' do
      let!(:legislature) { create(:legislature, deputy: deputy) }
      let!(:deputy_quota) { create(:deputy_quotum, legislature: legislature) }
      let!(:invoice) { create(:invoice, deputy_quotum: deputy_quota, deputy: deputy) }
      let!(:other_invoice) { create(:invoice, deputy_quotum: deputy_quota, deputy: deputy) }
      
      it 'should have invoices' do
        expect(deputy.invoices.count).to eq(2)
        expect(deputy.invoices).to include(invoice)
        expect(deputy.invoices).to include(other_invoice)
      end
    end
  end
end
