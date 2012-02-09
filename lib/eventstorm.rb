require 'time'
require 'bson'
require 'ffi-rzmq'

class Eventstorm
  # setup the eventstorm client
  # @param connstr - a connection string to the subscriber
  def self.setup connstr
    raise ArgumentError unless @instance.nil?
    @instance = Eventstorm.new(connstr)
  end

  # close the instance and delete the object completely
  def self.close
    @instance.close
    @instance = nil
  end

  # returns the single instance already built
  def self.instance
    @instance
  end

  # fires an event
  def self.fire(attributes = {})
    @instance.fire(attributes)
  end

  # class methods
  def initialize(connstr)
    @context = ZMQ::Context.new(1)
    @socket = @context.socket(ZMQ::PUB)
    @socket.connect(connstr)
  end

  # closes the socket
  def close
    @socket.close
  end

  # fires an event
  def fire(attributes)
    @socket.send_string(
      BSON::serialize(default_values.merge(attributes))
    )
  end

  def default_values
    {:event_time => Time.now.iso8601}
  end
end
