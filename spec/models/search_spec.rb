require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'create' do
    let(:term) { 'Valid term' }
    let(:slug) { 'valid-term' }

    context 'when record is valid' do
      before do
        Search.create(term: term, slug: slug)
      end

      it 'should save to table' do
        expect(Search.last.term).to eq(term)
        expect(Search.last.slug).to eq(slug)
        expect(Search.last.count).to eq(0)
      end
    end

    context 'when record is duplicated' do
      before do
        Search.create(term: term, slug: slug)
      end

      it 'should save to table' do
        expect{ Search.create!(term: term, slug: slug) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when missing required columns' do
      it 'should save to table' do
        expect{ Search.create!(term: term) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
