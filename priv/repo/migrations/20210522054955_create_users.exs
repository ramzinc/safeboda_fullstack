defmodule SafebodaFullstack.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :status, :string
      add :user_type, :string
      add :email, :string

      timestamps()
    end

  end
end
