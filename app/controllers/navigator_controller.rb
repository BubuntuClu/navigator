class NavigatorController < ApplicationController
  before_action :calculation_params, onlu: [:bd_table, :ruby_table]

  def index; end

  def show_distance
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

