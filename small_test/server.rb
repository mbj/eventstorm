require 'rubygems'
require 'bundler/setup'
require 'ffi-rzmq'

def debug str
  puts "Debug: #{str}"
end

# build a zmq context
context = ZMQ::Context.new(1)

# open a subscriber socket to get the messages
subscriber = context.socket(ZMQ::SUB)
code = subscriber.bind('tcp://*:9999')
if code == -1
  debug ZMQ::Util.error_string
end
debug subscriber.setsockopt(ZMQ::SUBSCRIBE, '')
puts "listening"

# try to read and print something
while true
  s = ''
  result = subscriber.recv_string(s)
  if result != 0
    debug ZMQ::Util.error_string
  end
  puts "got: #{s}"
end

subscriber.close
puts "killed"
