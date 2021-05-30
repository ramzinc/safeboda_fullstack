defmodule SafebodaFullstack.Repo.Migrations.AlterUserTypeStatus do
  use Ecto.Migration

  def change do
    alter table(:users)do
      remove :status, :string
    end
  end
end
