defmodule SafebodaFullstack.Accounts.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drivers" do
    field :suspended, :boolean, default: false
    field :user_id, :id
    timestamps()
  end

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:suspended, :user_id])
    |> validate_required([:suspended, :user_id])
  end
end
