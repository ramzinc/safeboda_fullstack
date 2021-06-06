defmodule SafebodaFullstack.Repo.Migrations.CreateRide do
  use Ecto.Migration

  def change do
    create table(:ride) do
      add :pickup_lat, :float
      add :pickup_lng, :float
      add :destination_lat, :float
      add :destination_lng, :float
      add :current_status, :string
      add :passenger_id, references(:users, on_delete: :nothing)
      add :driver_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:ride, [:passenger_id])
    create index(:ride, [:driver_id])
  end
end
