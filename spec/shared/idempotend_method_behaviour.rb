# encoding: utf-8
#
# stolen from veritas

shared_examples_for 'an idempotent method' do
  it 'is idempotent' do
    should equal(instance_eval(&self.class.subject))
  end
end
