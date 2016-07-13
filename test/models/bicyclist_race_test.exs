defmodule UphillRating.BicyclistRaceTest do
  use UphillRating.ModelCase

  alias UphillRating.BicyclistRace

  @valid_attrs %{lag: "14:00:00", place: 42, points: 42, time: "14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BicyclistRace.changeset(%BicyclistRace{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BicyclistRace.changeset(%BicyclistRace{}, @invalid_attrs)
    refute changeset.valid?
  end
end
