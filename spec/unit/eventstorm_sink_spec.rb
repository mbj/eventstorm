require 'eventstorm/sink'

describe Eventstorm::Sink do
  let (:connstr) { "tcp://*:9999" }
  let (:current_time) { Time.now.iso8601 }

  before do
    mock_zmq(connstr)
  end

  before :each do
    mock_zmq_prepare_messages
  end

  context Eventstorm::Sink, "setup" do
    before do
      @zmq_socket.should_receive(:bind).with(connstr)
    end

    after do
      Eventstorm::Sink::close
    end

    it "takes a socket description" do
      Eventstorm::Sink::setup("tcp://*:9999")
    end
  end

  context Eventstorm::Sink, "close" do
    before do
      @zmq_socket.should_receive(:close)
      Eventstorm::Sink::setup(connstr)
    end

    it "has to be closed" do
      Eventstorm::Sink::close
    end
  end

  context Eventstorm::Sink, "receive" do
    let (:event) { {'foo' => 'bar', 'baz' => 23, 'event_time' => current_time} }

    before do
      Eventstorm::Sink::setup(connstr)
    end

    before :each do
      push_message(event)
    end

    it "converts the event to a hash" do
      Eventstorm::Sink::receive.kind_of?(Hash).should be_true
    end

    it "returns the next event, when no argument is given" do
      Eventstorm::Sink::receive.should == event
    end

    it "takes a block to process events" do
      e = nil
      Eventstorm::Sink::receive do |new_event|
        e = new_event
      end
      e.should == event
    end

    context "block yielding for more messages" do
      before do
        mock_zmq_prepare_messages
        push_message(:error => true)
        push_message(:error => true)
        push_message(event)
        push_message(:error => true)
      end

      it "calls the block as there are messages" do
        e = nil
        Eventstorm::Sink::receive do |new_event|
          e = new_event
          if new_event.has_key?('event_time')
            break
          else
            puts "no!"
          end
        end
        e.should == event
      end
    end
  end
end
