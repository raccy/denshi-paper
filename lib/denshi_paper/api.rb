# frozen_string_literal: true

module DenshiPaper
  module API
    HTTP_PORT = 8080
    HTTPS_PORT = 8443
    KNOWN_API_VERSIONS = ['1.3'].freeze

    module Path
      SERIAL_NUMBER = '/register/serial_number'
      INFORMATION = '/register/information'
      API_VERSION = '/api_version'
    end
  end
end
