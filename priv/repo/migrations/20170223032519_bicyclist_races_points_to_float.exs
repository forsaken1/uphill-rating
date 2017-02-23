defmodule UphillRating.Repo.Migrations.BicyclistRacesPointsToFloat do
  use Ecto.Migration

  def change do
    alter table(:bicyclist_races) do
      modify :points, :float
    end
  end
end
