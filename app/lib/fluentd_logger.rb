class FluentdLogger
  def self.post_location(location)
    Fluent::Logger.post('location', location)
  end
end
