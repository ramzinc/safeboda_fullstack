defmodule SafebodaFullstack.Repo.Migrations.CreateOngoingRides do
  use Ecto.Migration

  def change do
    create table(:ongoing_rides) do
      add :passenger_id, references(:users, on_delete: :nothing)
      add :driver_id, references(:users, on_delete: :nothing)
      add :ride_id, references(:ride, on_delete: :nothing)

      timestamps()
    end

    create index(:ongoing_rides, [:passenger_id])
    create index(:ongoing_rides, [:driver_id])
    create index(:ongoing_rides, [:ride_id])
  end
end
