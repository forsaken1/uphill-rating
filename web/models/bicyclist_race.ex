defmodule UphillRating.BicyclistRace do
  use UphillRating.Web, :model

  schema "bicyclist_races" do
    field :time, Ecto.Time
    field :lag, Ecto.Time
    field :points, :integer
    field :place, :integer
    field :result_points, :float
    belongs_to :bicyclist, UphillRating.Bicyclist
    belongs_to :race, UphillRating.Race
    belongs_to :team, UphillRating.Team

    timestamps
  end

  @required_fields ~w(time bicyclist_id race_id team_id)
  @optional_fields ~w(place points result_points)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def sorted(query) do
    from p in query,
    order_by: [asc: p.time]
  end

  def ordered(query) do
    from p in query,
    order_by: [desc: p.points]
  end

  def for_race(query, race) do
    from c in query,
     join: p in assoc(c, :race),
    where: p.id == ^race.id
  end
end
