# frozen_string_literal: true

require 'rails_helper'

describe ImagesController, type: :controller do
  describe '#index' do
    subject { get :index, params: params }

    context 'with query' do
      let(:params) { { q: 'dog cat' } }
      let(:match_records) do
        [
          create(:image, tags: [create(:tag, name: 'hotdogs')]),
          create(:image, tags: [create(:tag, name: 'catalina')]),
        ]
      end
      let(:not_match_record) { create :image, tags: [create(:tag, name: 'bird')] }

      before do
        match_records
        not_match_record
      end

      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:images)).to match_array match_records
      end
    end

    context 'without query' do
      let(:params) { {} }
      let!(:image) { create :image }

      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:images)).to contain_exactly image
      end
    end

    context 'with page' do
      let(:params) { { page: 2 } }
      before { create :image }

      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:images)).to be_empty
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: id } }

    context 'image exists' do
      let(:image) { create :image }
      let(:id) { image.id }

      before { image }

      it do
        expect { subject }.to change { Image.count }.from(1).to(0)
        expect(subject).to redirect_to images_path
      end
    end

    context 'image does not exist' do
      let(:id) { 9999 }
      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
