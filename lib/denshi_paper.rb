# frozen_string_literal: true

require 'logger'

require 'denshi_paper/api'
require 'denshi_paper/client'
require 'denshi_paper/device'
require 'denshi_paper/discovery'
require 'denshi_paper/error'

module DenshiPaper
  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger ||= Logger.new($stderr).tap do |logger|
      logger.level = Logger::INFO
    end
  end
end
