# frozen_string_literal: true

require 'time'

module DenshiPaper
  class Entry
    TYPES = ['folder', 'document'].freeze

    attr_reader :created_data,
      :id, :name, :path, :type,
      :is_new, :parent_folder_id

    def initialize(data)
      @created_data = convert_time(data[:created_date])
      @id = convert_uuid(data[:entry_id])
      @name = data[:entry_name]
      @path = data[:entry_path]
      @type = data[:entry_type]
      @is_new = convert_bool(data[:is_new])
      @parent_folder_id = convert_uuid(data[:parent_folder_id])

      unless TYPES.include?(@type)
        raise InvalidDataError,
          "unknown type: #{@type}"
      end
    end

    def to_s
      id
    end

    private def convert_time(str)
      Time.iso8601(str)
    end

    private def convert_uuid(str)
      case str
      when 'root', /\A\h{8}-\h{4}-\h{4}-\h{4}-\h{12}\z/
        str
      when ''
        nil
      else
        raise InvalidDataError,
          "id must be 'root' or uuid: #{str}"
      end
    end

    private def convert_bool(str)
      case str
      when 'true'
        true
      when 'false'
        false
      else
        raise InvalidDataError,
          "not a boolean: #{str}"
      end
    end

    private def convert_int(str)
      unless str.match?(/\A\d+\z/)
        raise InvalidDataError,
          "not a integer: #{str}"
      end

      str.to_i
    end
  end
end
