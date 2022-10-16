require 'rails_helper'

RSpec.describe Invoice do
  let(:deputy) { create(:deputy) }
  let(:legislature) { create(:legislature, deputy: deputy) }
  let(:deputy_quota) { create(:deputy_quotum, legislature: legislature) }
  let(:invoice) { create(:invoice, deputy_quotum: deputy_quota, deputy: deputy) }

  describe 'validations' do
    context 'when document_number is missing' do
      before do
        invoice.document_number = nil
      end

      it 'is invalid' do
        expect(invoice.valid?).to be(false)
      end
    end
    
    context 'when document_number is present' do
      before do
        invoice.document_number = 743543416354635
      end

      it 'is valid' do
        expect(invoice.valid?).to be(true)
      end
    end
  end

  describe 'associations' do
    context 'belongs_to :provider' do
      it 'should have provider' do
        expect(invoice.provider).to be_instance_of(Provider)
      end
    end

    context 'belongs_to :deputy_quotum' do
      it 'should have deputy_quotum' do
        expect(invoice.deputy_quotum).to be_instance_of(DeputyQuotum)
      end
    end
  end
end
