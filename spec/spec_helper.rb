require 'bson'

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

def get_encoded_message
  @messages
end

def get_message
  BSON::deserialize(@messages.first)
end

# timestamp correction
def mock_time
  @timestamp = Time.now
  Time.stub(:new).and_return(@timestamp)
end

def current_time
  @timestamp
end
