# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  it 'is invalid without a name' do
    pet = build(:pet, name: nil)
    pet.valid?
    expect(pet.errors[:name]).to include("can't be blank")
  end

  it 'is invalid not uniq' do
    create(:pet, name: 'FOO')
    pet = build(:pet, name: 'FOO')
    pet.valid?
    expect(pet.errors[:name]).to include('has already been taken')
  end

  it 'is valid without tag' do
    pet = build(:pet, name: 'FOO', tag: nil)
    expect(pet.valid?).to eq true
  end
end
