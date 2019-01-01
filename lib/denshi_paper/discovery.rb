# frozen_string_literal: true

require 'json'
require 'net/http'
require 'resolv'

require 'denshi_paper/api'
require 'denshi_paper/device'

module DenshinPaper

  FUJITSU_DIGITAL_PAPER_SERVICE = 'dp_fujitsu'
  # TODO: Sony device
  #SONY_DIGITAL_PAPER_SERVICE =

  class Discovery
    def initialize
      @devices = []
    end

    def discover(service)
      host_list = search_mdns_service(service, 'tcp')
      tg = ThreadGroup.new
      host_list.map do |host|
        tg.add Thread.new() do
          Net::HTTP.start(host[:address], API::HTTP_PORT) do |http|
            http.get(API::Path::SERIAL_NUMBER)
          end
        end
      end
    end

    def check_device(name, address)
      Net::HTTP.start(host[:address], API::HTTP_PORT) do |http|
        response = http.get(API::Path::SERIAL_NUMBER)
        response_body = response.read_body
        if response
          response_data =
        if response
        http.get(API::Path::INFORAMTION)
        http.get(API::Path::API_VERSION)
      end

    end

    def search_mdns_service(service, protocol, domain = 'local', timeouts: nil)
      rdri = Resolv::DNS::Resource::IN
      srv_name = "_#{service}._#{protocol}.#{domain}."
      mdns = Resolv::MDNS.new
      mdns.timeouts = timeouts if timeouts
      mdns.getresources(srv_name, rdri::PTR)
        .map(&:name).uniq
        .flat_map { |name| mdns.getresources(name, rdri::SRV) }
        .map(&:target).uniq
        .flat_map do |target|
          [rdri::A, rdri::AAAA]
            .flat_map { |type| mdns.getresources(target, type) }
            .map { |a| { name: target.to_s, address: a.address.to_s } }
        end
    end
  end
end
