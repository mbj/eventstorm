# this is built with http://www.whatastruggle.com/rspec-and-zeromq as
# a template
def mock_zmq(connstr)
  zmq_socket = mock("zmq_socket")
  zmq_socket.stub(:connect).with(connstr)
  zmq_socket.stub(:close)
  zmq_socket.stub(:send_string) do |msg|
    @messages << msg
  end
  zmq_context = mock("zmq_context")
  zmq_context.stub(:socket).and_return(zmq_socket)
  ZMQ::Context.stub(:new).and_return(zmq_context)
end

def mock_zmq_prepare_messages
  @messages = []
end

def mock_zmq_get_messages
  @messages
end
