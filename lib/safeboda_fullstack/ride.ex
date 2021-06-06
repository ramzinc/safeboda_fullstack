defmodule SafebodaFullstack.Ride do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ride" do
    field :current_status, :string
    field :destination_lat, :float
    field :destination_lng, :float
    field :pickup_lat, :float
    field :pickup_lng, :float
    field :passenger_id, :id
    field :driver_id, :id

    timestamps()
  end

  @doc false
  def changeset(ride, attrs) do
    ride
    |> cast(attrs, [
      :passenger_id,
      :driver_id,
      :pickup_lat,
      :pickup_lng,
      :destination_lat,
      :destination_lng,
      :current_status
    ])
    |> validate_required([
      :passenger_id,
      :driver_id,
      :pickup_lat,
      :pickup_lng,
      :destination_lat,
      :destination_lng,
      :current_status
    ])
  end
end
