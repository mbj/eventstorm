require 'spec_helper'

describe Eventstorm::Client, '#fire' do
  let(:connect) { 'tcp://localhost:600' }
  let(:event) { {'event_name' => 'spec_test', 'rspectest' => true} }
  let(:object) { described_class.new([connect]) }

  subject { object.fire(event) }

  it "sends an event through the socket" do
    object.socket.should_receive(:send_string)
    subject
  end

  context 'when sending events' do
    let(:dummy_context) { DummyContext.new }
    before do
      Eventstorm.should_receive(:zmq_context).and_return(dummy_context)
    end

    it "sets 'event_time' in the event, when not given" do
      subject
      object.socket.decoded_message.has_key?('event_time').should be(true)
    end

    it "sends the event bson encoded" do
      subject
      BSON::deserialize(object.socket.messages.first).class.should
        be(BSON::OrderedHash)
    end
  end
end 
