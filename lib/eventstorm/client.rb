module Eventstorm
  class Client
    attr_reader :targets

  private

    # Initializes client
    #
    # @example
    #   Evenstorm::Client.new('localhost:3000') => <Evenstorm::Client @targets=['localhost:3000']>
    #
    # @param [String|Array<String>]
    #   targets events should be sent to
    #
    def initialize(target)
      @targets = [*target].map(&:freeze).freeze
    end
  end
end
