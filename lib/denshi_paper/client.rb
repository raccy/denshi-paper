# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'time'

require 'faraday-cookie_jar'

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
      @authed = false
    end

    private def connect
      @connect ||=
        Faraday.new(@device.https_url, ssl: { verify: false }) do |faraday|
          faraday.use :cookie_jar
          faraday.request :json
          faraday.response :logger, DenshiPaper.logger
          faraday.response :json, content_type: /\bjson$/,
                                  parser_options: { symbolize_names: true }
          faraday.response :raise_error
          faraday.adapter  :net_http
        end
    end

    def authed?
      @authed
    end

    def auth
      return true if authed?

      nonce = connect.get("/auth/nonce/#{@client_id}").body[:nonce]
      auth_data = {
        client_id: @client_id,
        nonce_signed:
          Base64.strict_encode64(@private_key.sign('sha256', nonce)),
      }
      res = connect.put('/auth', auth_data)
      @authed = res.success?
    end

    def config_datetime
      pp connect.headers
      connect.headers['Host'] = 'digitalpaper.local'
      connect.put('/system/configs/datetime', { value:  Time.now.utc.iso8601 })
    end

    def root
      config_datetime
      connect.get('/folders/root/entries').body
    end

  end
end
