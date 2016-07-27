defmodule UphillRating.Repo.Migrations.AddResultPointsToBicyclistRaces do
  use Ecto.Migration

  def change do
    alter table(:bicyclist_races) do
      add :result_points, :float
    end
  end
end
