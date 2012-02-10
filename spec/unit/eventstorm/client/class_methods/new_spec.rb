require 'spec_helper'

describe Eventstorm::Client,'.new' do
  let(:object) { Eventstorm::Client }
  let(:arguments) { [] }

  subject { object.new(*arguments) }

  context 'with target argument' do
    let(:arguments) { ['tcp://127.0.0.1:6000'] }

    it 'should store as targets array' do
      subject.targets.should == ['tcp://127.0.0.1:6000']
    end

    it 'should freeze targets array' do
      subject.targets.should be_frozen
    end

    it 'should freeze targets array members' do
      subject.targets.each { |member| member.should be_frozen }
    end
  end
end
