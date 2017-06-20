defmodule UphillRating.Repo.Migrations.BicyclistsUpdateIndex do
  use Ecto.Migration

  def change do
    drop index(:bicyclists, :name, unique: true)
    create index(:bicyclists, :name)
  end
end
