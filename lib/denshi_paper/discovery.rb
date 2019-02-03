# frozen_string_literal: true

require 'json'
require 'resolv'
require 'uri'
require 'timeout'

require 'faraday'
require 'faraday_middleware'
require 'parallel'

require 'denshi_paper/api'
require 'denshi_paper/device'

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
        Device.new(host[:address], hostname: host[:hostname])
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
      rdri = Resolv::DNS::Resource::IN
      srv_name = "_#{@service}._tcp.local."
      mdns = Resolv::MDNS.new
      mdns.timeouts = @timeout
      mdns.getresources(srv_name, rdri::PTR)
        .map(&:name).uniq
        .flat_map { |name| mdns.getresources(name, rdri::SRV) }
        .map(&:target).uniq
        .flat_map do |target|
          [rdri::A, rdri::AAAA]
            .flat_map { |type| mdns.getresources(target, type) }
            .map { |a| { hostname: target.to_s, address: a.address.to_s } }
        end
    end
  end
end
