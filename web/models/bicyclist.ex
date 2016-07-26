defmodule UphillRating.Bicyclist do
  use UphillRating.Web, :model

  schema "bicyclists" do
    field :name, :string
    field :year, :string
    field :sex, :string
    has_many :bicyclist_races, UphillRating.BicyclistRace

    timestamps
  end

  @required_fields ~w(name year sex)
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
