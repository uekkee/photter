# frozen_string_literal: true

require 'rails_helper'

describe TagsController, type: :controller do
  describe '#index' do
    subject { get :index, params: }

    context 'without page' do
      let(:params) { {} }
      let!(:tag) { create :tag }

      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:tags)).to contain_exactly tag
      end
    end

    context 'with page' do
      let(:params) { { page: 2 } }
      before { create :tag }

      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:tags)).to be_empty
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: } }

    context 'tag exists' do
      let(:tag) { create :tag }
      let(:id) { tag.id }

      before { tag }

      it do
        expect { subject }.to change { Tag.count }.from(1).to(0)
        expect(subject).to redirect_to tags_path
      end
    end

    context 'tag does not exist' do
      let(:id) { 9999 }
      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
