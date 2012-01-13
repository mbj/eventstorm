require 'rubygems'
require 'bundler/setup'
require 'ffi-rzmq'

# build the zmq context
context = ZMQ::Context.new(1)

# build a publisher socket
publisher = context.socket(ZMQ::PUB)
publisher.connect('tcp://127.0.0.1:9999')
puts "beginning with the sends"

while true
  s = $stdin.readline
  if s =~ /^\s[0-9].*/
    publisher.send_string(s)
  end
end

publisher.close
puts "killed"
