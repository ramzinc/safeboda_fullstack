defmodule SafebodaFullstack.Accounts.Passenger do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passengers" do
    field :user_id, :id
    timestamps()
  end

  @doc false
  def changeset(passenger, attrs) do
    passenger
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end
end
