# frozen_string_literal: true

require 'ipaddr'

module DenshiPaper
  attr_reader :addr

  class Device
    def initialize(serial: nil, addr: nil)
      @serial = serial
      addr = IPAddr.new(addr.to_s) unless addr.nil? || addr.is_a?(IPAddr)
      @addr = addr
    end
  end
end
