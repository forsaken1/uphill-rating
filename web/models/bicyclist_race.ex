defmodule UphillRating.BicyclistRace do
  use UphillRating.Web, :model

  schema "bicyclist_races" do
    field :time, Ecto.Time
    field :lag, Ecto.Time
    field :points, :integer
    field :place, :integer
    belongs_to :bicyclist, UphillRating.Bicyclist
    belongs_to :race, UphillRating.Race

    timestamps
  end

  @required_fields ~w(time lag points place)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
