defmodule UphillRating.Repo.Migrations.CreateBicyclist do
  use Ecto.Migration

  def change do
    create table(:bicyclists) do
      add :name, :string
      add :year, :string
      add :sex, :string
      timestamps
    end
  end
end
