# frozen_string_literal: true

# ペット
class Pet < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
