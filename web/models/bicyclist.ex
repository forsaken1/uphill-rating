defmodule UphillRating.Bicyclist do
  use UphillRating.Web, :model

  schema "bicyclists" do
    field :name, :string
    field :year, :string
    field :sex, :string
    has_many :bicyclist_races, UphillRating.BicyclistRace
    belongs_to :team, UphillRating.Team

    timestamps
  end

  @required_fields ~w(name year sex team_id)
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

  def order_by_name(query) do
    from b in query,
    order_by: [asc: b.year]
  end
end
