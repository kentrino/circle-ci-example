class FluentdLogger
  def self.post_location(geolocation)
    Fluent::Logger.post('location', geolocation)
  end
end
