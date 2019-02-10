# frozen_string_literal: true

require 'mutex_m'
require 'resolv'

module DenshiPaper
  module Utils
    class TemporaryHosts
      include Mutex_m

      def initialize()
        super
        @records = {}
      end

      def getaddress(name)
        enum_for(:each_address, name).first
      end

      def getaddresses(name)
        enum_for(:each_address, name).to_a
      end

      def getname(address)
        enum_for(:each_address, address).first
      end

      def getnames(address)
        enum_for(:each_name, address).to_a
      end

      def each_address(name, &proc)
        @records[name]&.each(&proc)
      end

      def each_name(address, &proc)
        @records[address]&.each(&proc)
      end

      def spoof(hosts_table)
        synchronize do
          register(hosts_table)
          yield
          clear
        end
      end

      private def register(hosts_table)
        @records.merge!(hosts_table)
      end

      private def clear
        @records.clear
      end
    end
  end
end
