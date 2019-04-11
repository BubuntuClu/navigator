class BuildingsSearcherService
  SEARCH_RADIUS = 4000

  attr_accessor :latitude, :longitude

  def initialize(params)
    self.latitude  = params[:latitude]
    self.longitude = params[:longitude]
  end

  def call
    buildings =
      Building.where(<<-SQL.squish, lat: latitude, lon: longitude)
        earth_box(ll_to_earth(:lat, :lon), #{SEARCH_RADIUS}) @> ll_to_earth(latitude, longitude)
          AND earth_distance(ll_to_earth(:lat, :lon), ll_to_earth(latitude, longitude)) < #{SEARCH_RADIUS}
        SQL
      .order Building.send(:sanitize_sql, "point(#{latitude}, #{longitude}) <@> point(latitude, longitude) :: point")

    buildings.map do |building|
      distance = building.distance_from([@latitude, @longitude]).round(3)
      { address: building.address, distance: distance }
    end
  end
end
