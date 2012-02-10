# this is built with http://www.whatastruggle.com/rspec-and-zeromq as
# a template
def mock_zmq(connstr)
  @zmq_socket = mock("zmq_socket")
  @zmq_socket.stub(:close)
  mock_for_client(connstr)
  mock_for_server(connstr)
  @zmq_context = mock("zmq_context")
  @zmq_context.stub(:socket).and_return(@zmq_socket)
  ZMQ::Context.stub(:new).and_return(@zmq_context)
end

# create all stubs for the client
def mock_for_client(connstr)
  @zmq_socket.stub(:connect).with(connstr)

  # send_string wants a string to send
  @zmq_socket.stub(:send_string) do |msg|
    if msg.class == String
      @messages.push(msg)
    else
      raise PrimitiveFailure, "Unable to write string"
    end
  end
end

# create the stubs for the server
def mock_for_server(connstr)
  @zmq_socket.stub(:bind).with(connstr)
  #
  # recv_string want's an object to receive the message
  @zmq_socket.stub(:recv_string) do |msg|
    msg.replace(@messages.shift)
    # this is the return value
    0
  end
end

def mock_zmq_prepare_messages
  @messages = []
end

def get_encoded_message
  @messages.first
end

def get_message
  BSON::deserialize(@messages.first)
end

def push_message msg
  @messages.push(BSON::serialize(msg).to_s)
end
