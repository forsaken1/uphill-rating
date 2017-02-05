defmodule UphillRating.Repo.Migrations.CreateRace do
  use Ecto.Migration

  def change do
    create table(:races) do
      add :name, :string
      add :information, :text
      add :climb, :integer
      add :date, :date
      timestamps
    end
    create index(:races, :name, unique: true)
  end
end
