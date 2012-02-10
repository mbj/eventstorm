require 'bson'

class Eventstorm
  class Sink
    def self.setup connstr
      @instance = Sink.new(connstr)
    end

    def self.close
      @instance.close
      @instance = nil
    end

    def self.receive
      if block_given?
        while true do
          yield @instance.receive
        end
      else
        @instance.receive
      end
    end

    def initialize connstr
      context = ZMQ::Context.new(1)
      @connection = context.socket(ZMQ::SUB)
      @connection.bind(connstr)
    end

    def close
      @connection.close
    end

    def receive
      message = ""
      code = @connection.recv_string(message)
      if code != 0
        raise ArgumentError.new("Transporterror: #{ZMQ::Util.error_string}")
      else
        return BSON::deserialize(message)
      end
    end
  end
end
