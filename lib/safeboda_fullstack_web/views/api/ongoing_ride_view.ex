defmodule SafebodaFullstackWeb.Api.Admin.OngoingRideView do
  use SafebodaFullstackWeb, :view

  def render("ongoing_ride.json", %{ongoing_ride: ongoing_ride}) do
    %{
      ride_id: ongoing_ride.ride_id,
      driver_id: ongoing_ride.driver_id,
      passenger_id: ongoing_ride.passenger_id
    }
  end

  # def render("ongoing_rides.json", %{ongoing_rides: ongoing_rides}) do
  #   render_many(ongoing_rides, __MODULE__, "ongoing_ride.json")
  # end
end
