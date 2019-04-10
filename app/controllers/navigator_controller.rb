class NavigatorController < ApplicationController
  def index; end

  def show_distance
    building_distance = BuildingsSearcherService.new(location_params).call

    render json: { building_distance: building_distance }
  end

  private

  def location_params
    params.permit(:latitude, :longitude)
  end
end
