defmodule UphillRating.Repo.Migrations.CreateBicyclistRace do
  use Ecto.Migration

  def change do
    create table(:bicyclist_races) do
      add :time, :time
      add :lag, :time
      add :points, :integer
      add :place, :integer
      add :bicyclist_id, references(:bicyclists, on_delete: :nothing)
      add :race_id, references(:races, on_delete: :nothing)
      timestamps
    end
    create index(:bicyclist_races, [:bicyclist_id])
    create index(:bicyclist_races, [:race_id])
  end
end
