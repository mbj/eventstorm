require 'bson'

class Event
  attr_accessor :name, :time, :value

  def to_bson
    BSON::serialize({
      :event_name => @event,
      :event_time => @time,
      :event_value => @value
    })
  end
end
