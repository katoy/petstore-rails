# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, js: true, type: :system, selenium: true do
  context 'ペット一覧' do
    context 'ペットが未登録' do
      it 'ペット一覧' do
        visit pets_path
        expect(current_path).to eq pets_path
        expect(page.text).to eq '{"pets":[]}'
      end
    end

    context 'ペットが 1頭 登録' do
      let(:pet_one) do
        travel_to Time.zone.parse("2022-01-02 00:01:02.000Z") do
          create :pet, name: 'イグアナ', tag: 'トカゲ'
        end
      end
      before { pet_one }

      let(:expect_text) do
        id = pet_one.id
        "{\"pets\":[{\"id\":#{id},\"name\":\"イグアナ\",\"tag\":\"トカゲ\",\"created_at\":\"2022-01-02T00:01:02.000Z\",\"updated_at\":\"2022-01-02T00:01:02.000Z\"}]}"
      end

      it 'ペット一覧' do
        visit pets_path
        expect(current_path).to eq pets_path
        expect(page.text).to eq expect_text
      end
    end
  end
end
