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

module DenshinPaper
  FUJITSU_DIGITAL_PAPER_SERVICE = 'dp_fujitsu'
  # TODO: Sony device
  # SONY_DIGITAL_PAPER_SERVICE =

  class Discovery
    def initialize(service: FUJITSU_DIGITAL_PAPER_SERVICE, timeout: 60)
      @service = service
      @timeout = timeout
      @devices = []
    end

    def search_device
      devices = search_mdns_service.map do |host|
        Device.new(host[:address], hostname: host[:hostname])
      end

      Parallel.map(devices, in_threads: 4) do |device|
        Timeout.timeout(@timeout) do
          [device.serial_number, device]
        end
      # rescue => e
      #   Denshi_paper.logger.warn(e)
      #   [nil, nil]
      end.to_hash.compact.valuse
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
