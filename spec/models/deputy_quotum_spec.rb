require 'rails_helper'

RSpec.describe DeputyQuotum do
  let(:deputy) { create(:deputy) }
  let(:legislature) { create(:legislature, deputy: deputy) }
  let(:deputy_quotum) { create(:deputy_quotum, legislature: legislature) }

  describe 'validations' do
    context 'when sub_quota_number is missing' do
      before do
        deputy_quotum.sub_quota_number = nil
      end

      it 'is invalid' do
        expect(deputy_quotum.sub_quota_number).to be_nil
      end
    end
    
    context 'when sub_quota_number is present' do
      before do
        deputy_quotum.sub_quota_number = 743543416
      end

      it 'is valid' do
        expect(deputy_quotum.valid?).to be(true)
      end
    end
  end

  describe 'associations' do
    context 'has_many :invoices' do
      let!(:invoice) { create(:invoice, deputy_quotum: deputy_quotum, deputy: deputy) }
      let!(:other_invoice) { create(:invoice, deputy_quotum: deputy_quotum, deputy: deputy) }
      
      it 'should have invoices' do
        expect(deputy_quotum.invoices.count).to eq(2)
        expect(deputy_quotum.invoices).to include(invoice)
        expect(deputy_quotum.invoices).to include(other_invoice)
      end
    end
  end
end
