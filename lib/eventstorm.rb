require 'time'
require 'bson'
require 'ffi-rzmq'

require 'eventstorm/client'

module Eventstorm
  # Access global zmq_context
  #
  # @return [ZMQ::Context]
  #
  # @api public
  def self.zmq_context
    @zmq_context ||= ZMQ::Context.new(1)
  end

  def self.setup(target)
    if @client
      raise 'Eventstorm.setup was already called'
    end

    @client = Client.new(target)

    self
  end

  def self.client
    if @client
      return @client
    end
    raise 'Eventstorm was not setup, call Eventstorm.setup(target)'
  end

  def self.fire
    @client.fire
  end
end
