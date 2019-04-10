class BuildingsSearcherService
  attr_accessor :latitude, :longitude

  def initialize(params)
    self.latitude  = params[:latitude]
    self.longitude = params[:longitude]
  end

  def call
    buildings =
      Building.where(<<-SQL.squish, lat: latitude, lon: longitude)
        earth_box(ll_to_earth(:lat, :lon), 4000) @> ll_to_earth(latitude, longitude)
          AND earth_distance(ll_to_earth(:lat, :lon), ll_to_earth(latitude, longitude)) < 4000
        SQL

    buildings.map do |building|
      distance = building.distance_from([@latitude,@longitude]).round(3)
      { address: building.address, distance: distance }
    end.sort_by { |building| building[:distance] }
  end
end
