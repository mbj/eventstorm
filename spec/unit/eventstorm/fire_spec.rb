require 'spec_helper'

describe Eventstorm, '.fire' do
  let (:object) { described_class }
  let (:connect) { 'tcp://localhost:600' }
  let (:subject) { Eventstorm.fire }

  before :each do
    Eventstorm.setup(connect)
  end

  it "uses the client to fire an event" do
    Eventstorm.client.should_receive(:fire)
    subject
  end
end
