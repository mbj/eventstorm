module Eventstorm
  # Abstract base class for event sources
  class Source
    include Adamantium::Flat, AbstractType

    # Enumerate events
    #
    # @return [self]
    #   if block given
    #
    # @return [Enumerator<Event>]
    #   otherwise
    #
    # @api private
    #
    abstract_method :each

    class Elasticsearch < self
      include Composition.new(:index)

      # Enumerate events
      #
      # @return [self]
      #   if block given
      #
      # @return [Enumerator<Event>]
      #
      # @api private
      #
      def each(&block)
        return to_enum unless block_given?
        result = index.read({:match_all => {}})
        result.hits.map do |foo|
          raise
          p foo
        end
      end

    end

    # Event source with predefined events
    class Static < self
      include Composition.new(:events)

      # Enumerate events
      #
      # @return [self]
      #   if block given
      #
      # @return [Enumerator<Event>]
      #   otherwise
      #
      # @api private
      #
      def each(&block)
        return to_enum unless block_given?
        events.each(&block)
        self
      end

    end
  end
end
