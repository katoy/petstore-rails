# frozen_string_literal: true

# ペット
class PetSerializer < ApplicationSerializer
  def to_json(*)
    @object.to_json(only: %i[id name tag])
  end
end
