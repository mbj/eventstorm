# this is a black hole, which subscribes to messages but will never
# send them further

require 'helper/logger'

logger = Logger.new(Logger::DEBUG, $stdout)
context = ZMQ::Context.new(1)

logger.debug 'starting black hole router'

# open a subscriber socket to get the messages
subscriber = context.socket(ZMQ::SUB)
code = subscriber.bind('tcp://*:9999')

if code == -1
  logger.debug 'error: ' + ZMQ::Util.error_string
end

logger.debug('subscribe status: ' + subscriber.setsockopt(ZMQ::SUBSCRIBE, '').to_s)

while true
  s = ''
  result = subscriber.recv_string(s)
  if result != 0
    logger.debug 'error: '+ZMQ::Util.error_string
  end
  event = Event.from_bson(s)
  puts "got: #{event.name}"
end
