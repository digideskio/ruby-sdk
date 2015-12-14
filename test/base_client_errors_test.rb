require 'test_helper'

module PortaText
  module Test
    # Tests the base client implementation for normal errors.
    #
    # Author::    Marcelo Gornstein (mailto:marcelog@portatext.com)
    # Copyright:: Copyright (c) 2015 PortaText
    # License::   Apache-2.0
    class BaseClientErrors < Minitest::Test
      def test_server_error
        client = CustomClient.new 500
        assert_raises PortaText::Exception::ServerError do
          client.run 'some/endpoint', :post, 'application/json', '{}'
        end
      end

      def test_rate_limited
        client = CustomClient.new 429
        assert_raises PortaText::Exception::RateLimited do
          client.run 'some/endpoint', :post, 'application/json', '{}'
        end
      end

      def test_invalid_method
        client = CustomClient.new 405
        assert_raises PortaText::Exception::InvalidMethod do
          client.run 'some/endpoint', :post, 'application/json', '{}'
        end
      end

      def test_invalid_media
        client = CustomClient.new 415
        assert_raises PortaText::Exception::InvalidMedia do
          client.run 'some/endpoint', :post, 'application/json', '{}'
        end
      end
    end

    class CustomClient < PortaText::Client::BaseClient
      def execute(_descriptor)
        [@code, @headers, @body]
      end

      def initialize(code, headers = {}, body = '{"success": true}')
        super()
        @code = code
        @headers = headers
        @body = body
      end
    end
  end
end