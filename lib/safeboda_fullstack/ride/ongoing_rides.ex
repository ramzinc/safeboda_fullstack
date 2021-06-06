defmodule SafebodaFullstack.Ride.OngoingRides do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ongoing_rides" do
    field :passenger_id, :id
    field :driver_id, :id
    field :ride_id, :id

    timestamps()
  end

  @doc false
  def changeset(ongoing_rides, attrs) do
    ongoing_rides
    |> cast(attrs, [:passenger_id, :driver_id, :ride_id])
    |> validate_required([:passenger_id, :driver_id, :ride_id])
  end
end
