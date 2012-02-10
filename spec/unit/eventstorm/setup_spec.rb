require 'spec_helper'

describe Eventstorm,'.setup' do
  after :each do
    # Reset Eventstorm module in prishtine state
    if Eventstorm.instance_variable_defined?(:@client)
      Eventstorm.send(:remove_instance_variable,:@client)
    end
  end

  let(:object) { described_class }
  subject { object.setup(target) }

  context 'when it was not called before accessing client' do
    it 'should raise error' do
      expect do
        object.client.should
      end.to raise_error(RuntimeError,'Evenstorm was not setup, call Evenstorm.setup(target)')
    end
  end

  context 'when called' do
    let(:target) { 'tcp://localhost:600' }

    it 'should store instance in Evenstorm.client' do
      subject
      object.client.should be_a(Eventstorm::Client)
    end

    it 'should initialize client with target' do
      subject
      object.client.targets.should == [target]
    end

    it 'should return self' do
      subject.should == described_class
    end
  end

  context 'when called twice' do
    let(:target) { 'tcp://localhost:600' }

    it 'should raise error' do
      subject
      expect { subject }.to raise_error(RuntimeError,'Eventstorm.setup was already called')
    end
  end
end
