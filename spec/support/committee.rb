# frozen_string_literal: true

RSpec.configure do |config|
  config.add_setting :committee_options
  config.committee_options = {
    schema_path: Rails.root.join('dest/openapi/openapi.yaml').to_s,
    query_hash_key: 'rack.request.query_hash',
    parse_response_by_content_type: false
  }
end
