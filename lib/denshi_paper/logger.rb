# frozen_string_literal: true

require 'logger'

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
