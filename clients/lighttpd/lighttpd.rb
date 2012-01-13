#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'ffi-rzmq'

# build the zmq context
context = ZMQ::Context.new(1)

# build a publisher socket
publisher = context.socket(ZMQ::PUB)
publisher.connect('tcp://127.0.0.1:9999')
puts "beginning with the sends"

until $stdin.eof?
  s = $stdin.readline
  publisher.send_string(s)
end

publisher.send_string("End of send #{Time.now}")
publisher.close
puts "killed"
