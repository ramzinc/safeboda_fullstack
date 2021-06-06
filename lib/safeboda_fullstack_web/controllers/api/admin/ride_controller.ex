defmodule SafebodaFullstackWeb.Api.Admin.RideController do
  use SafebodaFullstackWeb, :controller
  alias SafebodaFullstack.Accounts

  def new(conn, params) do
    IO.inspect(params)

    case Accounts.create_ride(params) do
      {:ok, ride} -> render(conn, "ride.json", %{ride: ride})
      {:error, error} -> send_resp(conn, 409, "#{error}")
    end
  end

  def stop(conn, params) do
    case Accounts.stop_ride(params) do
      {:ok, {:ok, done_ride}} ->
        IO.inspect(done_ride)
        render(conn, "ride.json", %{ride: done_ride})

      {:error, error} ->
        send_resp(conn, 400, error)
    end
  end

  def ongoing(conn, _params) do
    ongoing_rides = Accounts.get_ongoing_rides()
    render(conn, "ongoing_rides.json", %{ongoing_rides: ongoing_rides})
  end
end
