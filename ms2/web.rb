#!/usr/bin/env ruby
require 'sinatra'
require 'net/http'
require 'uri'

set :bind, '0.0.0.0'

get '/' do
  "Hello there\n"
end