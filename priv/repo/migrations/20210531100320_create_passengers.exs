defmodule SafebodaFullstack.Repo.Migrations.CreatePassengers do
  use Ecto.Migration

  def change do
    create table(:passengers) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:passengers, [:user_id])
  end
end
