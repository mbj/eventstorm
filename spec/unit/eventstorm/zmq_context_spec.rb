require 'spec_helper'

describe Eventstorm,'.zmq_context' do
  let(:object) { described_class }

  subject { object.zmq_context }

  it 'should return a ZMQ::Context' do
    subject.should be_a(ZMQ::Context)
  end

  it_should_behave_like 'an idempotent method'
end
