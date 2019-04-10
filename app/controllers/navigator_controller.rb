class NavigatorController < ApplicationController
  before_action :calculation_params, onlu: [:bd_table, :ruby_table]

  def index; end

  def bd_table
    #injection?
    query = <<-SQL
      SELECT
        address, (point(#{@latitude}, #{@longitude}) <@> point(latitude, longitude) :: point) AS miles,
        (point(#{@latitude}, #{@longitude}) <@> point(latitude, longitude) :: point) * 1609.34 AS distance
      FROM
          buildings
      WHERE
          earth_box(ll_to_earth(#{@latitude}, #{@longitude}), 4000) @> ll_to_earth(latitude, longitude)
          AND earth_distance(ll_to_earth(#{@latitude}, #{@longitude}),
                   ll_to_earth(latitude, longitude)) < 4000
      ORDER BY distance
    SQL

    render json: { building_distance: Building.connection.execute(query) }
  end

  def ruby_table
    buildings = Building.where(<<-SQL.squish, lat: @latitude, lon: @longitude)
    earth_box(ll_to_earth(:lat, :lon), 4000) @> ll_to_earth(latitude, longitude)
      AND earth_distance(ll_to_earth(:lat, :lon),
               ll_to_earth(latitude, longitude)) < 4000

    SQL
    building_distance = buildings.map do |building|
      distance = building.distance_from([@latitude,@longitude]).round(3)

      { address: building.address, distance: distance }
    end
    building_distance.sort_by! { |k| k[:distance] }
    render json: { building_distance: building_distance }
  end

  private

  def calculation_params
    @latitude = params[:latitude]
    @longitude = params[:longitude]
  end
end




























# end
# Building.select(<<-SQL.squish, lat: @latitude, lon: @longitude)
# address , (point(:lat, :lon) <@> point(latitude, longitude) :: point) * 1609.34 AS distance2
#   FROM
#       buildings
#   WHERE
#       earth_box(ll_to_earth(:lat, :lon), 4000) @> ll_to_earth(latitude, longitude)
#       AND earth_distance(ll_to_earth(:lat, :lon),
#                ll_to_earth(latitude, longitude)) < 4000
#   ORDER BY distance
# SQL


# SELECT
#         *,point(55.737324,37.609038) <@> point(latitude, longitude) :: point AS distance
#     FROM
#         buildings
#     WHERE
#         /* First condition allows to search for points at an approximate distance:
#            a distance computed using a 'box', instead of a 'circumference'.
#            This first condition will use the index.
#            (45.1013021, 46.3021011) = (lat, lng) of search center.
#            25000 = search radius (in m)
#         */
#         earth_box(ll_to_earth(55.737324,37.609038), 4000) @> ll_to_earth(latitude, longitude)

#         /* This second condition (which is slower) will "refine"
#            the previous search, to include only the points within the
#            circumference.
#         */
#         AND earth_distance(ll_to_earth(55.737324,37.609038),
#                  ll_to_earth(latitude, longitude)) < 4000
#     ORDER BY distance

# @latitude = 55.737324
# @longitude = 37.609038


# .order(:distance)

# Building.where('earth_box(ll_to_earth(?,?), 4000) @> ll_to_earth(latitude, longitude)AND earth_distance(ll_to_earth(?,?),ll_to_earth(latitude, longitude)) < 4000', @latitude, @longitude, @latitude, @longitude).select('*, point(?,?) <@> point(latitude, longitude)::point AS distance', @latitude, @longitude)

