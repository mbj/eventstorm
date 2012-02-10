require 'spec_helper'

describe Eventstorm::Client,'#socket' do
  let(:connect) { 'tcp://localhost:600' }
  let(:object) { described_class.new([connect]) }

  let(:dummy_context) { DummyContext.new }

  subject { object.socket }

  it 'should return a ZMQ::Socket' do
    subject.should be_a(ZMQ::Socket)
  end

  it_should_behave_like 'an idempotent method'

  it 'should use global eventstorm zmq context' do
    Eventstorm.should_receive(:zmq_context).and_return(dummy_context)
    subject
  end

  it 'should connect all targets' do
    Eventstorm.stub(:zmq_context => dummy_context)
    subject
    dummy_context.sockets.first.connects.should == object.targets
  end
end
