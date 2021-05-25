defmodule SafebodaFullstack.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :status, :string
    field :user_type, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :phone_number, :status, :user_type, :email])
    |> validate_required([:first_name, :last_name, :phone_number, :status, :user_type, :email])
  end
end
