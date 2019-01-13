# frozen_string_literal: true

require 'logger'

module DenshiPaper
  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger ||= Logger.new($stderr).tap do |logger|
      logger.level = $DEBUG ? Logger::DEBUG : Logger::INFO
    end
  end
end
