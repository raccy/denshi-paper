# frozen_string_literal: true

module DenshiPaper
  class File < Entry
    TYPE = 'document'

    DOCUMENT_TYPES = ['normal', 'note'].freeze
    MIME_TYPES = ['application/pdf'].freeze

    attr_reader :author,
      :current_page, :document_type, :file_revision, :file_size,
      :mime_type, :modified_date, :reading_date,
      :title, :total_page

    def initialize(data)
      super
      raise InvalidDataError, 'not a document type' unless type == TYPE

      @author = data[:author]
      @current_page = convert_int(data[:current_page])
      @document_type = data[:document_type]
      @file_revision = data[:file_revision]
      @file_size = convert_int(data[:file_size])
      @mime_type = data[:mime_type]
      @modified_date = convert_time(data[:modified_date])
      @reading_date = data[:reading_date]&.yield_self { |s| convert_time(s) }
      @title = data[:title]
      @total_page = convert_int(data[:total_page])

      unless DOCUMENT_TYPES.include?(@document_type)
        raise InvalidDataError, "unknowen document type: #{@document_type}"
      end

      unless MIME_TYPES.include?(@mime_type)
        raise InvalidDataError, "unknowen mime type: #{@document_type}"
      end


    end
  end
end
