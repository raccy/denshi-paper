# frozen_string_literal: true

require 'mutex_m'

module DenshiPaper
  module Utils
    class TemporaryHosts
      include Mutex_m

      def initialize()
        @records = {}
      end

      # Resolvの定義をそのまま流用する
      %i[getaddress getaddresses getname getnames].each do |sym|
        define_method(sym, Resolv.instance_method(sym))
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
