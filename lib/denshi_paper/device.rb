# frozen_string_literal: true

require 'ipaddr'
require 'faraday'
require 'faraday_middleware'

module DenshiPaper
  class Device
    DEFAULT_HOSTNAME = 'digitalpaper.local'
    HTTP_PORT = 8080
    HTTPS_PORT = 8443
    KNOWN_API_VERSIONS = ['1.3'].freeze

    attr_reader :address, :hostname

    def initialize(address, hostname: DEFAULT_HOSTNAME, serial_number: nil)
      @address = address
      @hostname = hostname
      @serial_number = serial_number
    end

    def to_h
      {
        address: address,
        hostname: hostname,
        serial_number: serial_number,
        device_color: deveice_color,
        model_nome: model_name,
        sku_code: sku_code,
        api_version: api_version,
      }
    end

    def http_url(use_ip: false)
      if use_ip
        URI::HTTP.build(host: @address, port: HTTP_PORT)
      else
        URI::HTTP.build(host: @hostname, port: HTTP_PORT)
      end
    end

    def https_url(use_ip: false)
      if use_ip
        URI::HTTPS.build(host: @address, port: HTTPS_PORT)
      else
        URI::HTTPS.build(host: @hostname, port: HTTPS_PORT)
      end
    end

    # コネクタを取得する。
    # IPアドレス接続
    # クッキー不要
    # 返答はJSONをシンボルネーム化したHash
    private def connect
      @connect ||= Faraday.new(http_url(use_ip: true)) do |faraday|
        faraday.request :json
        faraday.response :logger, DenshiPaper.logger
        faraday.response :json, content_type: /\bjson$/,
                                parser_options: { symbolize_names: true }
        faraday.response :raise_error
        faraday.adapter  :net_http
      end
    end

    private def connect_get(*opts)
      connect.get(*opts)
    end

    def serial_number
      @serial_number ||= connect_get('/register/serial_number').body[:value]
        .tap do |data|
        unless /\A\d+\z/.match?(data)
          raise InvalidDataError, 'Invalid serial number. ' \
            "serial_number: #{data}"
        end
      end
    end

    def device_color
      @device_color ||= information[:device_color]
    end

    def model_name
      @model_name ||= information[:model_name]
    end

    def sku_code
      @sku_code ||= information[:sku_code]
    end

    private def information
      @information ||= connect.get('/register/information').body.tap do |data|
        unless serial_number == data[:serial_number]
          raise InvalidDataError, 'Serial numbers do not match. ' \
            "information.serial_number: #{data.serial_number}, " \
            "but expected: #{@seirial_number}"
        end
      end
    end

    def api_version
      @api_version ||= connect.get('/api_version').body[:value]
        .tap do |data|
        unless API::KNOWN_API_VERSIONS.include?(data)
          raise "Unknown api version. api_version: #{data}"
        end
      end
    end
  end
end
