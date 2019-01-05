# frozen_string_literal: true

require 'webrick'
require 'webrick/https'
require 'openssl'
require 'net/http'
require 'pp'
require 'thwait'
require 'stringio'

module WEBrick
  module HTTPServlet
    class ProcHandler
      alias do_HEAD do_GET
      alias do_PUT do_GET
      alias do_DELETE do_GET
      alias do_OPTIONS do_GET
    end
  end
end

SERVER_CRT = OpenSSL::X509::Certificate.new(File.read('./server.crt'))
SERVER_PKEY = OpenSSL::PKey::RSA.new(File.read('./server.key'))

# Fujitsu FMV-DPP01, FMV-DPP02
DP_SERVICE = '_dp_fujitsu._tcp'

def run_avahi_pub
  avahi_pub_pid = spawn("avahi-publish -s dp #{DP_SERVICE} 8080")
  at_exit do
    Process.kill('TERM', avahi_pub_pid)
  end
  avahi_pub_pid
end

def run_wrap(address, port: nil, scheme: 'http')
  count = 0

  with_port = port.nil? ? '' : ":#{port}"
  url = URI.parse("#{scheme}://#{address}#{with_port}/")
  ssl_enable = url.scheme == 'https'

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = ssl_enable
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  server = WEBrick::HTTPServer.new(
    Port: url.port,
    SSLEnable: ssl_enable,
    SSLCertificate: ssl_enable ? SERVER_CRT : nil,
    SSLPrivateKey: ssl_enable ? SERVER_PKEY : nil
  )

  server.mount_proc('/') do |req, res|
    session_id = (count += 1)
    puts ">>> req #{url} [#{session_id}] #{Time.now} >>>"
    puts req.to_s

    http.start unless http.started?

    # req.path はURLエスケープ済みなので使えない
    http_req = case req.request_method
    when 'GET'
      Net::HTTP::Get.new(req.request_uri.path)
    when 'HEAD'
      Net::HTTP::Head.new(req.request_uri.path)
    when 'POST'
      Net::HTTP::Post.new(req.request_uri.path)
    when 'PUT'
      Net::HTTP::Put.new(req.request_uri.path)
    when 'DELETE'
      Net::HTTP::Delete.new(req.request_uri.path)
    when 'OPTIONS'
      Net::HTTP::Options.new(req.request_uri.path)
    else
      raise "unsupported method: #{req.request_method}"
    end

    req.header.each do |name, vals|
      val = vals.join(', ')
      http_req[name] = val
    end

    %w[accept accept_charset accept_encoding accept_language].each do |name|
      vals = req.send(name)
      if vals && !vals.empty?
        val = vals.join(', ')
        http_req[name.gsub('_', '-')] = val
      end
    end

    if req.cookies && !req.cookies.empty?
      cookies = req.cookies.map(&:to_s).join('; ')
      http_req['cookie'] = cookies
    end

    if req.body && !req.body.empty?
      http_req.body = req.body
    end

    http_res = http.request(http_req)

    res.status = http_res.code.to_i

    puts "<<< res #{url} [#{session_id}] #{Time.now} <<<"
    puts "HTTP/#{http_res.http_version} #{http_res.code} #{http_res.msg}"
    http_res.each_capitalized_name do |name|
      http_res.get_fields(name).each do |val|
        puts "#{name}: #{val}"
        if name == 'Set-Cookie'
          res.cookies << WEBrick::Cookie.parse_set_cookie(val)
        else
          res[name] = val
        end
      end
    end

    res.body = http_res.body if http_res.body

    puts http_res.body
    res
  end

  Thread.start do
    server.start
  end
end

if $0 == __FILE__
  address = ARGV[0]
  run_avahi_pub
  threads = []
  threads << run_wrap(address, port: 8080)
  threads << run_wrap(address, port: 8443, scheme: 'https')
  thall = ThreadsWait.new(*threads)
  thall.all_waits do |th|
    puts "=== #{th.inspect} ==="
  end
end
