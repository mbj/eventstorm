require 'spec_helper'
require 'logger'

describe Eventstorm  do
  let(:static_source) do
    Eventstorm::Source::Static.new(events)
  end

  let(:events) do
    [
      Eventstorm::Event.build('foo', 'bar' => 'baz')
    ]
  end

  let(:es_cluster) do
    Elasticsearch::Cluster.connect(ENV.fetch('ELASTICSEARCH_URL', 'http://localhost:9200'))
  end

  let(:es_index) do
    es_cluster.index('eventstorm-test')
  end
  
  let(:es_sink) do
    Eventstorm::Sink::Elasticsearch.new(es_index)
  end

  let(:inmemory_sink) do
    Eventstorm::Sink::Memory.new
  end

  let(:es_source) do
    Eventstorm::Source::Elasticsearch.new(es_index)
  end

  it 'elasticsearch should consume events' do
    es_index.delete if es_index.exist?
    Eventstorm.connect(static_source, es_sink)
  end

  it 'should read events' do
    Eventstorm.connect(es_source, inmemory_sink)
    inmemory_sink.events.should eql(events)
  end
end
