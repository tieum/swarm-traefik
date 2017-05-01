port ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'

bind 'tcp://0.0.0.0:3000'