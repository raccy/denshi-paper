# frozen_string_literal: true

require 'openssl'
require 'securerandom'

require 'denshi_paper/error'

module DenshiPaper
  class Client
    attr_reader :client_id, :private_key

    def initialize(client_id, private_key, pass = nil)
      @address = address
      @client_id = client_id
      @private_key =
        if private_key.is_a?(OpenSSL::PKey::RSA)
          private_key
        else
          OpenSSL::PKey::RSA.new(private_key, pass)
        end
    end

    def register_device(device)
      
    end

    def self.generate
      client_id = SecureRandom.uuid
      private_key = OpenSSL::PKey::RSA.generate(2048)
      self.new(client_id, private_key)
    end
  end
end
