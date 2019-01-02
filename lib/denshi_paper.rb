# frozen_string_literal: true

require 'logger'

# require 'denshi_paper/client'

module DenshiPaper
  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger ||= Logger.new($stdin)
  end
end
