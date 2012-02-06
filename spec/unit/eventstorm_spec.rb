require 'eventstorm'
require 'socket'
require 'ffi-rzmq'

# ZMQ.should_receive(:message).with(first_arg,second_arg).and_return(the_result)

describe Eventstorm do
  let (:connstr) { "tcp://127.0.0.1:32198" }
  describe "when starting a client" do

    it "returns the client after setup" do
      Eventstorm::setup(connstr).class.should == Eventstorm
      Eventstorm::close
    end

    describe "build a single instance" do
      before do
        Eventstorm::setup(connstr)
      end

      after do
        Eventstorm::close
      end

      it "returns an instance, when the setup was successfull" do
        Eventstorm::instance.class.should == Eventstorm
      end

      it "raises an error when setup gets called a seond time" do
        expect { Eventstorm.setup(connstr) }.to raise_error
      end
    end

    describe "starting the zmq connection" do
      # TODO there has to be a way to make this better
      let (:zmq_socket) { double(ZMQ::Socket) }
      let (:zmq_context) { double(ZMQ::Context) }
      before do
        ZMQ::Context.should_receive(:new).with(1).
          and_return(zmq_context)
        zmq_context.should_receive(:socket).with(ZMQ::PUB).
          and_return(zmq_socket)
        zmq_socket.should_receive(:connect).with(connstr)
        zmq_socket.should_receive(:close)
      end

      it "builds a socket and opens the connection" do
        Eventstorm::setup(connstr)
        Eventstorm::close
      end
    end
  end

  describe "firing events" do
    it "fires an event with default values filled" do
    end

    it "fires an event when given a key value pair" do

    end

    it "fires an event when given a hash of multiple keys" do
    end
  end
end
