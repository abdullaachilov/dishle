ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    fixtures :all
  end
end

module ActionDispatch
  class IntegrationTest
    def json_response
      JSON.parse(response.body)
    end

    def auth_headers(user)
      { "Authorization" => "Bearer #{user.session_token}" }
    end

    def json_post(path, params: {}, headers: {})
      post path, params: params.to_json, headers: { "Content-Type" => "application/json" }.merge(headers)
    end

    def json_delete(path, headers: {})
      delete path, headers: headers
    end
  end
end
