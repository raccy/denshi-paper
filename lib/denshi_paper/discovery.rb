# frozen_string_literal: true

require 'json'
require 'resolv'
require 'uri'
require 'timeout'

require 'faraday'
require 'faraday_middleware'
require 'parallel'

module DenshiPaper
  FUJITSU_DIGITAL_PAPER_SERVICE = 'dp_fujitsu'
  # TODO: Sony device
  # SONY_DIGITAL_PAPER_SERVICE =

  class Discovery
    def initialize(service: FUJITSU_DIGITAL_PAPER_SERVICE, timeout: 60)
      @service = service
      @timeout = timeout
      @devices = []
    end

    def search_device(serial_number = nil)
      if serial_number
        search_device_map[serial_number]
      else
        search_device_map.values
      end
    end

    private def search_device_map
      devices = search_mdns_service.map do |host|
        # ホスト名は設定しない
        Device.new(host[:address])
      end
      DenshiPaper.logger.debug(devices)

      Parallel.map(devices, in_threads: 4) do |device|
        begin
          Timeout.timeout(@timeout) do
            [device.serial_number, device]
          end
        rescue => e
          DenshiPaper.logger.warn(e.message)
          [nil, nil]
        end
      end.to_h.compact
    end

    def search_mdns_service
      srv_name = "_#{@service}._tcp.local."
      DenshiPaper.mdns.getresources(srv_name, Resolv::DNS::Resource::IN::PTR)
        .map(&:name).uniq
        .flat_map { |name|
          DenshiPaper.mdns.getresources(name, Resolv::DNS::Resource::IN::SRV)
        }.map(&:target).uniq
        .flat_map do |target|
          [Resolv::DNS::Resource::IN::A, Resolv::DNS::Resource::IN::AAAA]
            .flat_map { |type| DenshiPaper.mdns.getresources(target, type) }
            .map { |a| { hostname: target.to_s, address: a.address.to_s } }
        end
    end
  end
end
