require 'rails_helper'

RSpec.describe SearchHistory, type: :model do
  describe 'create' do
    let(:term) { 'Valid term' }
    let(:slug) { 'validterm' }
    let(:session_key) { 'valid-key' }

    context 'when record is valid' do
      before do
        SearchHistory.create(session_key: session_key, term: term)
      end

      it 'should save' do
        expect(SearchHistory.last.term).to eq(term)
        expect(SearchHistory.last.session_key).to eq(session_key)
      end
    end

    context 'when record is duplicated' do
      before do
        SearchHistory.create(session_key: session_key)
      end

      it 'should throw exception' do
        expect{ SearchHistory.create!(session_key: session_key, term: term) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when missing required columns' do
      it 'should throw exception' do
        expect{ SearchHistory.create!(term: term) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when update' do
      before do
        sh = SearchHistory.create(session_key: session_key)
        sh.update(term: term)
      end

      it 'should save slug' do
        expect(SearchHistory.last.slug) .to eq(slug)
      end
    end
  end
end
