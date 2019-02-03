# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'faraday-cookie_jar'

require 'denshi_paper/error'

module DenshiPaper
  class Client
    attr_reader :device

    def initialize(device, client_id, private_key, pass = nil)
      @device = device
      @client_id = client_id
      @private_key =
        if private_key.is_a?(OpenSSL::PKey::RSA)
          private_key
        else
          OpenSSL::PKey::RSA.new(private_key, pass)
        end
    end

    private def connect
      @connect ||= Faraday.new(@device.https_url) do |faraday|
        faraday.use :cookie_jar
        faraday.request :json
        faraday.response :logger, DenshiPaper.logger
        faraday.response :json, content_type: /\bjson$/,
                                parser_options: { symbolize_names: true }
        faraday.response :raise_error
        faraday.adapter  :net_http
      end
    end

    def nonce
      connect.get("/auth/nonce/#{@client_id}").body[:nonce]
    end

    def auth
      auth_data = {
        client_id: @client_id,
        nonce_signed: Base64.strict_encode64(
          @private_key.sign('sha256', nonce)),
      }
      connect.put('/auth', auth_data)
    end
  end
end
