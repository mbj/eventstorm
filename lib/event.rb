require 'bson'

module Eventstorm
  class Event
    attr_accessor :name, :time, :value

    # convert the event to a bson object
    def to_bson
      BSON::serialize({
        :event_name => @name,
        :event_time => @time,
        :event_value => @value
      })
    end

    # creates an event from a bson string
    def self.from_bson string
      h = BSON.deserialize(string)
      e = Event.new
      e.name = h['event_name']
      e.time = h['event_time']
      e.value = h['event_value']
      return e
    end
  end
end
