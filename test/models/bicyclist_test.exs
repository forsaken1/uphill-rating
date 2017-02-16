defmodule UphillRating.BicyclistTest do
  use UphillRating.ModelCase

  alias UphillRating.Bicyclist

  @valid_attrs %{name: "some content", sex: "some content", year: "some content", team_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bicyclist.changeset(%Bicyclist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bicyclist.changeset(%Bicyclist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
