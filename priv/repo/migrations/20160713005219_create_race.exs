defmodule UphillRating.Repo.Migrations.CreateRace do
  use Ecto.Migration

  def change do
    create table(:races) do
      add :information, :text
      add :climb, :integer
      timestamps
    end
  end
end
