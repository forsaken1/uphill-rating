defmodule UphillRating.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      timestamps()
    end
    create index(:teams, :name, unique: true)
  end
end
