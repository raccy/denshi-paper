# frozen_string_literal: true

module DenshiPaper
  class Folder < Entry
    def initialize(data)
      super
      @type = 'folder'
      raise InvalidDataError, 'Is not folder type' if @type == data[:entry_type]
    end
  end
end
