defmodule SafebodaFullstackWeb.Api.Admin.RideView do
  use SafebodaFullstackWeb, :view
  alias SafebodaFullstackWeb.Api.Admin.OngoingRideView

  def render("ride.json", %{ride: ride}) do
    %{
      data: %{
        ride_id: ride.id,
        passenger_id: ride.passenger_id,
        driver_id: ride.driver_id,
        current_status: ride.current_status
      }
    }
  end

  def render("ongoing_rides.json", %{ongoing_rides: ongoing_rides}) do
    %{data: render_many(ongoing_rides, OngoingRideView, "ongoing_ride.json")}
  end

  # def render("ongoing_ride.json", %{ongoing_ride: ongoing_ride}) do
  #   %{
  #     data: %{
  #       ride_id: ongoing_ride.ride_id,
  #       driver_id: ongoing_ride.driver_id,
  #       passenger_id: ongoing_ride.passenger_id
  #     }
  #   }
  # end
end
