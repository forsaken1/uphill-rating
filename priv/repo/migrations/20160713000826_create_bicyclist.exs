defmodule UphillRating.Repo.Migrations.CreateBicyclist do
  use Ecto.Migration

  def change do
    create table(:bicyclists) do
      add :name, :string
      add :year, :string
      add :sex, :string
      add :team_id, references(:teams, on_delete: :nothing)
      timestamps
    end
  end
end
