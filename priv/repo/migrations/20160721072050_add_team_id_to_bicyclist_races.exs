defmodule UphillRating.Repo.Migrations.AddTeamIdToBicyclistRaces do
  use Ecto.Migration

  def change do
    alter table(:bicyclist_races) do
      add :team_id, references(:teams, on_delete: :nothing)
    end
  end
end
