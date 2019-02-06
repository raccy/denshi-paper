# frozen_string_literal: true

# WARNING: "resolv-replace" has side effect.
require 'resolv'
Resolv::DefaultMDNS = Resolv::MDNS.new
Resolv::DefaultResolver.replace_resolvers([Resolv::DefaultMDNS])
require 'resolv-replace'

require 'logger'

require 'denshi_paper/api'
require 'denshi_paper/client'
require 'denshi_paper/device'
require 'denshi_paper/discovery'
require 'denshi_paper/entry'
require 'denshi_paper/folder'

module DenshiPaper
  VERSION = '0.1.0'

  class InvalidDataError < StandardError
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger ||= Logger.new($stderr).tap do |logger|
      logger.level = $DEBUG ? Logger::DEBUG : Logger::INFO
    end
  end
end
