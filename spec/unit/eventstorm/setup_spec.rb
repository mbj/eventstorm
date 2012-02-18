require 'spec_helper'

describe Eventstorm,'.setup' do
  before :each do
    Eventstorm.instance_variable_set(:@client,nil)
  end

  let(:object) { described_class }

  subject { object.setup(target) }

  context 'when it was not called before accessing client' do
    it 'should raise error' do
      expect do
        object.client.should
      end.to raise_error(RuntimeError,'Eventstorm was not setup, call Eventstorm.setup(target)')
    end
  end

  context 'when called' do
    let(:target) { 'tcp://localhost:600' }

    it 'should store instance in Eventstorm.client' do
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
      object.setup(target)
      expect { subject }.to raise_error(RuntimeError,'Eventstorm.setup was already called')
    end
  end
end
