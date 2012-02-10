$LOAD_PATH << File.expand_path('../../lib',__FILE__)
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each { |f| require f }
require 'eventstorm'

class DummySocket
  attr_reader :type
  attr_reader :connects

  def initialize(type)
    @type = type
    @connects = []
  end

  def connect(connectstring)
    @connects << connectstring
  end
end

class DummyContext
  attr_reader :sockets

  def initialize
    @sockets = []
  end

  def socket(type)
    socket = DummySocket.new(type)
    @sockets << socket
    socket
  end
end
