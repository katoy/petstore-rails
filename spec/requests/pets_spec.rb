# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/pets', type: :request do
  include Committee::Rails::Test::Methods

  let(:json) { JSON.parse(response.body) }

  describe 'GET /pets' do
    subject(:call_api) { get pets_path, as: :json }

    context 'empty' do
      it do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(200)
        expect(response).to have_http_status '200'
      end
    end

    context 'some pets' do
      before do
        create(:pet, name: '土佐犬')
        create(:pet, name: 'ペルシャ猫')
      end

      let(:expect_json) do
        Pet.order(:id).map do |p|
          { 'id' => p.id, 'name' => p.name, 'tag' => p.tag }
        end
      end

      it do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(200)
        expect(response).to have_http_status '200'
        expect(json).to eq expect_json
      end
    end
  end

  describe 'GET /pets/{id}' do
    subject(:call_api) { get pet_path(id), as: :json }

    before do
      create(:pet, name: '土佐犬')
      create(:pet, name: 'ペルシャ猫')
    end

    context 'invalid id' do
      let(:id) { Pet.order(:id).last.id + 1 }
      let(:expect_json) { {} }

      it do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(404)
        expect(response).to have_http_status '404'
        expect(json).to eq expect_json
      end
    end

    context 'valid id' do
      let(:id) { Pet.order(:id).last.id }
      let(:expect_json) do
        pet = Pet.order(:id).last
        { 'id' => pet.id, 'name' => 'ペルシャ猫', 'tag' => pet.tag }
      end

      it do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(200)
        expect(response).to have_http_status '200'
        expect(json).to eq expect_json
      end
    end
  end

  describe 'POST /pets/' do
    subject(:call_api) { post pets_path, params: params, as: :json }

    context 'no name' do
      let(:params) { { name: '', tag: 'dog' } }
      let(:expect_json) { { 'name' => ["can't be blank"] } }

      it do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(422)
        expect(response).to have_http_status '422'
        expect(json).to eq expect_json
      end
    end

    context 'no tag' do
      let(:params) { { name: '三毛猫' } }
      let(:expect_json) do
        pet = Pet.order(:id).last
        { 'id' => pet.id, 'name' => '三毛猫', 'tag' => nil }
      end

      it do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(201)
        expect(response).to have_http_status '201'
        expect(json).to eq expect_json
      end
    end

    context 'when duplicate' do
      let(:params) { { name: '秋田犬', tag: 'dog' } }
      let(:expect_json) do
        { 'name' => ['has already been taken'] }
      end

      before { create(:pet, name: '秋田犬', tag: 'dog') }

      it 'creates a pet' do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(422)
        expect(response).to have_http_status '422'
        expect(json).to eq expect_json
      end
    end

    context 'when invalid' do
      before do
        create(:pet, name: '芝犬', tag: '犬')
      end

      let(:params) { { name: '芝犬', tag: '犬' } }
      let(:expect_json) { { 'name' => ['has already been taken'] } }

      it 'does not create a pet' do
        call_api

        assert_request_schema_confirm
        assert_response_schema_confirm(422)
        expect(response).to have_http_status '422'
        expect(json).to eq expect_json
      end
    end
  end
end
