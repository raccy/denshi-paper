# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'time'

require 'faraday-cookie_jar'

module DenshiPaper
  class Client
    attr_reader :device

    def initialize(device, client_id, private_key, pass = nil)
      @device = device
      @client_id = client_id
      @private_key =
        if private_key.is_a?(OpenSSL::PKey::RSA)
          private_key
        else
          OpenSSL::PKey::RSA.new(private_key, pass)
        end
      @authed = false
      @host2addr = {@device.hostname => [@device.address]}
    end

    # コネクタを取得する。
    # ホスト名接続
    # クッキー必要
    # 返答はJSONをシンボルネーム化したHash
    private def connect
      @connect ||=
        Faraday.new(@device.https_url, ssl: { verify: false }) do |faraday|
          faraday.use :cookie_jar
          faraday.request :json
          faraday.response :logger, DenshiPaper.logger
          faraday.response :json, content_type: /\bjson$/,
                                  parser_options: { symbolize_names: true }
          faraday.response :raise_error
          faraday.adapter  :net_http
        end
    end

    # 一時的なホスト名に対するIPアドレスを使用してGETする。
    private def connect_get(*opts)
      res = nil
      DenshiPaper.spoof_hosts(@host2addr) do
        res = connect.get(*opts)
      end
      res
    end

    # 一時的なホスト名に対するIPアドレスを使用してPUTする。
    private def connect_put(*opts)
      res = nil
      DenshiPaper.spoof_hosts(@host2addr) do
        res = connect.put(*opts)
      end
      res
    end

    def authed?
      @authed
    end

    def auth
      return true if authed?

      nonce = connect_get("/auth/nonce/#{@client_id}").body[:nonce]
      auth_data = {
        client_id: @client_id,
        nonce_signed:
          Base64.strict_encode64(@private_key.sign('sha256', nonce)),
      }
      res = connect.put('/auth', auth_data)
      @authed = res.success?
    end

    def config_datetime
      connect_put('/system/configs/datetime', value: Time.now.utc.iso8601)
    end

    def root
      config_datetime
      connect_get('/folders/root/entries').body
    end

  end
end
