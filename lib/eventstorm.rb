require 'abstract_type'
require 'adamantium'
require 'concord'
require 'esearch'
require 'anima'

# Root namespace
module Eventstorm

  # The event that storms around ;)
  class Event
    include Anima.new(:id, :time, :type, :payload)

    # Build object a pretty lame way
    #
    # Will be refactored away later.
    #
    # @param [String] type
    # @param [Hash] payload
    #
    # @return [Event]
    #
    # @api private
    #
    def self.build(type, payload)
      new(
        :id      => payload.object_id,
        :type    => type,
        :time    => Time.now,
        :payload => payload
      )
    end

    # Return hash representation
    #
    # Will be refactored away later.
    #
    # @return [Hash]
    #
    # @api private
    #
    def to_hash
      self.class.attributes_hash(self)
    end

  end

  # Connect source to sink
  #
  # Will be refactored away later.
  #
  # @param [Source] source
  # @param [Sink] sink
  #
  # @return [self]
  #
  # @api private
  #
  def self.connect(source, sink)
    source.each do |event|
      sink.push(event)
    end
    self
  end

end

require 'eventstorm/sink'
require 'eventstorm/source'
