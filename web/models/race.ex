defmodule UphillRating.Race do
  use UphillRating.Web, :model

  schema "races" do
    field :name, :string
    field :information, :string
    field :climb, :integer
    field :date, Ecto.Date
    has_many :bicyclist_races, UphillRating.BicyclistRace
    timestamps
  end

  @required_fields ~w(name climb date)
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
