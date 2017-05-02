#!/usr/bin/env ruby
require 'sinatra'
require 'net/http'
require 'uri'

set :bind, '0.0.0.0'

get '/' do
  uri = URI(ENV['MS_URL'])
#  http = Net::HTTP.new(uri.host, uri.port)
#  response = http.request(Net::HTTP::Get.new(uri.request_uri))
  puts "callling ms2"
  response = Net::HTTP.get_response(uri)
  status = response.code == '200' ? 'OK': 'NOK'

  "Hello, world. I'm #{status}(#{response.code})\n"
end