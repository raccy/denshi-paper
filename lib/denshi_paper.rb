# frozen_string_literal: true

# WARNING: "resolv-replace" has side effect.
require 'resolv'
require 'resolv-replace'
require 'logger'

require 'denshi_paper/client'
require 'denshi_paper/device'
require 'denshi_paper/discovery'
require 'denshi_paper/entry'
require 'denshi_paper/folder'
require 'denshi_paper/utils'

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

  def self.mdns
    @mdns ||= Register::MDNS.new
  end

  def self.hosts
    @hosts ||= Utils::TemporaryHosts.new
  end

  def self.init_resolvers
    return if @resolvers_initialized

    Resolv::DefaultResolver.replace_resolvers([
      hosts,
      Resolv::DefaultResolver,
      mdns,
    ])
    @resolvers_initialized = true
  end

  def self.spoof_hosts(hosts_table, &proc)
    init_resolvers
    hosts.spoof(hosts_table, &proc)
  end
end
