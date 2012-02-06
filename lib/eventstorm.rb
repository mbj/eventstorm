class Eventstorm
  # setup the eventstorm client
  # @param connstr - a connection string to the subscriber
  def self.setup connstr
    raise ArgumentError unless @instance.nil?
    @instance = Eventstorm.new(connstr)
  end

  def self.close
    @instance.close
    @instance = nil
  end

  def self.instance
    @instance
  end

  # class methods
  def initialize(connstr)
    @context = ZMQ::Context.new(1)
    @socket = @context.socket(ZMQ::PUB)
    @socket.connect(connstr)
  end

  def close
    @socket.close
  end
end
