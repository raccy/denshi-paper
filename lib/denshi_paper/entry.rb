# frozen_string_literal: true

module DenshiPaper
  class Entry
    def initialize(data)
      @id = data[:entry_id]
      @name = data[:entry_name]
      @path = data[:entry_path]
      @parent_folder_id = data[:parent_folder_id]
    end
  end
end
