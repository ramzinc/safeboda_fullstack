defmodule SafebodaFullstack.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SafebodaFullstack.Accounts.Driver
  alias SafebodaFullstack.Accounts.Passenger
  @derive Jason.Encoder

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :user_type, :string
    has_one :drivers, Driver
    has_one :passengers, Passenger
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :phone_number, :user_type, :email])
    |> validate_required([:first_name, :last_name, :phone_number, :user_type])
  end
end
