#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'ffi-rzmq'
#require 'json'
require 'bson'
require 'socket'

# this script uses the following log format
# log format for csv
# %h host ip
# %t timestamp of the end of the request
# %m request method
# %s status code
# %b bytes sent
# %U request URL
# %f real filename
# %q query string
# %T time used in secounds
# accesslog.format = "%h|%t|%m|%s|%b|%U|%f|%q|%T|%{User-Agent}i|%{Referer}i"

# build the zmq context
context = ZMQ::Context.new(1)
event_source = "http.#{Socket.gethostname}."
event_types = {}
['GET', 'POST', 'PUT', 'DELETE', 'HEAD'].each do |method|
  event_types[method] = event_source + method.downcase
end

# build a publisher socket
publisher = context.socket(ZMQ::PUB)
publisher.connect('tcp://127.0.0.1:9999')
puts "beginning with the sends"

until $stdin.eof?
  event_time = Time.now
  logline = $stdin.readline.split('|')
  event = {
    :event_name => event_types[logline[2]],
    :event_time => event_time,
    :event_value => {
      :http_code          => logline[3],
      :http_response_size => logline[4],
      :http_url           => logline[5],
      :http_filename      => logline[6],
      :http_query_string  => logline[7],
      :http_time_taken    => logline[8],
      :http_user_agent    => logline[9],
      :http_referer       => logline[10]
    }
  }
  publisher.send_string(BSON::serialize(event).to_s)
end

publisher.send_string("End of send #{Time.now}")
publisher.close
puts "killed"
