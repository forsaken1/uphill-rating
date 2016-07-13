defmodule UphillRating.RaceTest do
  use UphillRating.ModelCase

  alias UphillRating.Race

  @valid_attrs %{climb: 42, information: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Race.changeset(%Race{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Race.changeset(%Race{}, @invalid_attrs)
    refute changeset.valid?
  end
end
