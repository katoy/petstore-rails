# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users', type: :request do
  include Committee::Rails::Test::Methods

  let(:json) { JSON.parse(response.body) }

  describe 'POST /users' do
    context 'when valid' do
      it 'creates a user' do
        post api_v1_users_url, params: {
          username: 'johndoe',
          password: 'p@ssw0rd',
          first_name: 'John',
          last_name: 'Doe',
          email: 'john.doe@example.com',
          phone: '03-1234-5678'
        }, as: :json

        assert_request_schema_confirm
        assert_response_schema_confirm(201)
        expect(json).to eq expect_json
      end

      let(:expect_json) do
        user = User.all.order(:id).last
        {
          'id' => user.id,
          'username' => user.username,
          'first_name' => user.first_name,
          'last_name' => user.last_name,
          'email' => user.email,
          'phone' => user.phone
        }
      end
    end

    context 'when invalid' do
      before do
        create(
          :user,
          {
            username: 'johndoe',
            password: 'p@ssw0rd',
            first_name: 'John',
            last_name: 'Doe',
            email: 'john.doe@example.com',
            phone: '03-1234-5678'
          }
        )
      end

      let(:expect_json) do
        {
          'password' => ["can't be blank", 'is too short (minimum is 6 characters)'],
          'username' => ['has already been taken'],
          'first_name' => ["can't be blank"],
          'last_name' => ["can't be blank"],
          'email' => ['has already been taken'],
          'phone' => ['is invalid', "can't be blank"]
        }
      end

      it 'does not create a user' do
        post api_v1_users_url, params: {
          username: 'johndoe',
          password: '',
          first_name: '',
          last_name: '',
          email: 'john.doe@example.com',
          phone: ''
        }, as: :json

        assert_request_schema_confirm
        assert_response_schema_confirm(422)
        expect(json).to eq expect_json
      end
    end
  end
end
