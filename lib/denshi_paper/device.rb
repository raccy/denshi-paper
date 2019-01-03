# frozen_string_literal: true

require 'ipaddr'
require 'faraday'
require 'faraday_middleware'

module DenshiPaper
  class Device
    DEFAULT_HOSTNAME = 'digitalpaper.local'

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

    def http_url
      @http_url ||= URI::HTTP.build(host: address, port: API::HTTP_PORT)
    end

    def https_url
      @https_url ||= URI::HTTPS.build(host: address, port: API::HTTPS_PORT)
    end

    private def connect
      @connect ||= Faraday.new(http_url) do |faraday|
        faraday.response :logger, DenshiPaper.logger
        faraday.response :json, content_type: /\bjson$/
        faraday.response :raise_error
        faraday.adapter  Faraday.default_adapter
      end
    end

    def serial_number
      @serial_number ||= begin
        data = connect.get(API::Path::SERIAL_NUMBER).body['value']
        unless /\A\d+\z/.match?(data)
          raise "Invalid serial number. serial_number: #{data}"
        end
        data
      end
    end

    def device_color
      @device_color ||= information['device_color']
    end

    def model_name
      @model_name ||= information['model_name']
    end

    def sku_code
      @sku_code ||= information['sku_code']
    end

    private def information
      @information ||= begin
        data = connect.get(API::Path::INFORMATION).body
        unless serial_number == data['serial_number']
          raise 'Serial numbers do not match. ' \
            "information.serial_number: #{data.serial_number}, " \
            "but expected: #{@seirial_number}"
        end
        data
      end
    end

    def api_version
      @api_version ||= begin
        data = connect.get(API::Path::API_VERSION).body['value']
        unless API::KNOWN_API_VERSIONS.include?(data)
          raise "Unknown api version. api_version: #{data}"
        end
        data
      end
    end
  end
end
