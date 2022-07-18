# frozen_string_literal: true

# ユーザー
class UserSerializer < ApplicationSerializer
  def to_json(*)
    @object.to_json(only: %i[id username first_name last_name email phone])
  end
end
