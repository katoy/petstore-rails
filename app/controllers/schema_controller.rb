# frozen_string_literal: true

# スキーマ
class SchemaController < ActionController::Base
  def openapi
    render file: Rails.root.join('dest/openapi/openapi.yaml')
  end

  def rapidoc
    render file: Rails.root.join('dest/index.html')
  end
end
