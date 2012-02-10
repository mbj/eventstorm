require 'time'
require 'bson'
require 'ffi-rzmq'

require 'eventstorm/helpers'
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
    if defined?(@client)
      raise 'Evenstorm.setup was already called'
    end
    @client = Client.new(target)

    self
  end

  def self.client
    if defined?(@client)
      return @client
    end
    raise 'Evenstorm was not setup, call Evenstorm.setup(target)'
  end
end
