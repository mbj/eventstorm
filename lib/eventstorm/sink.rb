module Eventstorm

  # Abstract base class for event sinks
  class Sink
    include Adamantium::Flat, AbstractType

    # Push event to sink
    #
    # @param [Event] event
    #
    # @return [self]
    #
    # @api private
    #
    abstract_method :push

    # Memory sink
    class Memory < self

      # Return sunken events
      #
      # @return [Enumerable<Event>]
      # 
      # @api private
      #
      attr_reader :events

      # Initialize object
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize
        @events = []
      end

      # Push event to sink
      #
      # @param [Event] event
      #
      # @return [self]
      #
      # @api private
      #
      def push(event)
        events << event
        self
      end

    end

    # Elasticsearch index sink
    class Elasticsearch < self
      include Composition.new(:index)

      # Push event to sink
      #
      # @param [Event] event
      #
      # @return [self]
      #
      # @api private
      #
      def push(event)
        index.type(event.type).document(event.id).index(event.to_hash)
        self
      end

    end
  end

end
