require 'spec_helper'
require 'eventstorm'

# ZMQ.should_receive(:message).with(first_arg,second_arg).and_return(the_result)

describe Eventstorm do
  # set some used defualts and mocks
  let (:connstr) { "tcp://127.0.0.1:32198" }
  let (:current_time) { Time.now }
  let (:zmq_socket) { double(ZMQ::Socket) }
  let (:zmq_context) { double(ZMQ::Context) }
  
  context "starting up" do
    it "returns an eventstorm object after setup" do
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

  context "firing an event" do
    before do
      mock_zmq(connstr)
      Eventstorm::setup(connstr)
    end

    before :each do
      mock_zmq_prepare_messages
    end

    after do
      Eventstorm::close
    end

    it "uses bson for transport" do
      Eventstorm::fire()
      BSON::deserialize(get_encoded_message.first
                       )['event_time'].should == current_time.iso8601
    end

    it "adds a timestamp" do
      Eventstorm::fire()
      get_message.should == {'event_time' => current_time.iso8601 }
    end

    it "fires an event when given a key value pair" do
      Eventstorm::fire(:foo => :bar)
      get_message['foo'].should == :bar
    end

    it "converts symbol keys to stings" do
      Eventstorm::fire(:foo => :bar)
      get_message['foo'].should == :bar
    end

    it "fires an event when given a hash of multiple keys" do
      sample = {'a' => 'b', 'c' => 23, 'event_time' => current_time.to_s}
      Eventstorm::fire(sample)
      get_message.should == sample
    end
  end
end
