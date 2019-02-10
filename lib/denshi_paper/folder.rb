# frozen_string_literal: true

module DenshiPaper
  class Folder < Entry
    TYPE = 'folder'

    def initialize(data)
      super
      raise InvalidDataError, 'not a folder type' unless type == TYPE
    end
  end
end
