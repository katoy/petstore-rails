# frozen_string_literal: true

# エラー
class ErrorSerializer < ApplicationSerializer
  def to_json(*)
    @object.errors.to_json
  end
end
