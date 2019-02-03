# frozen_string_literal: true

require 'openssl'
require 'securerandom'

require 'denshi_paper/error'

module DenshiPaper
  class Client
    attr_reader :client_id, :private_key

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
        faraday.request :json
        faraday.response :logger, DenshiPaper.logger
        faraday.response :json, content_type: /\bjson$/,
                                parser_options: { symbolize_names: true }
        faraday.response :raise_error
        faraday.adapter  :net_http
      end
    end

    def get_information_by_host(host)
      url = URI::HTTP.build(host: host, port: API::HTTP_PORT)
      conn = Faraday.new(url) do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.use :cookie_jar
        faraday.response :logger, @logger
        faraday.response :json, content_type: /\bjson$/
        faraday.response :mashify
        faraday.response :raise_error
        faraday.adapter  Faraday.default_adapter
      end

      serial_number = conn.get(API::Path::SERIAL_NUMBER).body['value']
      information = conn.get(API::Path::INFORMATION).body
      api_version = conn.get(API::Path::API_VERSION).body['value']
      information.merge({
        serial_number: serial_number,
        api_version: api_version,
      })
    rescue => e
      @logger.error(e)
      return
    end

    def self.generate
      client_id = SecureRandom.uuid
      private_key = OpenSSL::PKey::RSA.generate(2048)
      self.new(client_id, private_key)
    end
  end
end
