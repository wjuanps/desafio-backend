require 'rails_helper'

RSpec.describe Legislature do
  let(:deputy) { create(:deputy) }
  let(:legislature) { create(:legislature, deputy: deputy) }

  describe 'validations' do
    context 'when legislature_number, legislature_code are all missing' do
      before do
        legislature.legislature_number = nil
      end

      it 'is invalid' do
        expect(legislature.valid?).to be(false)
      end
    end

    context 'when legislature_number, legislature_code are all present' do
      before do
        legislature.legislature_number = rand(1...10)
        legislature.legislature_code = rand(1...10)
      end

      it 'is valid' do
        expect(legislature.valid?).to be(true)
      end
    end
  end

  describe 'associations' do
    context 'has_many :deputy_quota' do
      let!(:deputy_quota) { create(:deputy_quotum, legislature: legislature) }
      let!(:other_deputy_quota) { create(:deputy_quotum, legislature: legislature) }

      it 'should have deputy_quota' do
        expect(legislature.deputy_quota.count).to eq(2)
        expect(legislature.deputy_quota).to include(deputy_quota)
        expect(legislature.deputy_quota).to include(other_deputy_quota)
      end
    end

    context 'belongs_to :deputy' do
      it 'should have deputy' do
        expect(legislature.deputy).to be_instance_of(Deputy)
      end
    end
  end
end
