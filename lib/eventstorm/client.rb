module Eventstorm
  class Client
    attr_reader :targets


    def socket
      return @socket if defined?(@socket)
      socket = Eventstorm.zmq_context.socket(ZMQ::PUB)

      @targets.each do |target|
        socket.connect(target)
      end

      @socket = socket
    end

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
