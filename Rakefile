require 'rubygems'
require 'bundler/setup'
require 'ffi-rzmq'
require 'lib/event'

namespace :client do
  desc 'start the lighttpd client'
  task :lighttpd do
    # TODO is require the correct thing to do here?
    require 'clients/lighttpd/lighttpd'
  end
end
