defmodule UphillRating.Team do
  use UphillRating.Web, :model

  schema "teams" do
    field :name, :string
    has_many :bicyclists, UphillRating.Bicyclist
    has_many :bicyclist_races, UphillRating.BicyclistRace

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
