defmodule UphillRating.BicyclistRaceControllerTest do
  use UphillRating.ConnCase

  alias UphillRating.BicyclistRace
  @valid_attrs %{lag: "14:00:00", place: 42, points: 42, time: "14:00:00"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bicyclist_race_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bicyclist races"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bicyclist_race_path(conn, :new)
    assert html_response(conn, 200) =~ "New bicyclist race"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bicyclist_race_path(conn, :create), bicyclist_race: @valid_attrs
    assert redirected_to(conn) == bicyclist_race_path(conn, :index)
    assert Repo.get_by(BicyclistRace, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bicyclist_race_path(conn, :create), bicyclist_race: @invalid_attrs
    assert html_response(conn, 200) =~ "New bicyclist race"
  end

  test "shows chosen resource", %{conn: conn} do
    bicyclist_race = Repo.insert! %BicyclistRace{}
    conn = get conn, bicyclist_race_path(conn, :show, bicyclist_race)
    assert html_response(conn, 200) =~ "Show bicyclist race"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bicyclist_race_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bicyclist_race = Repo.insert! %BicyclistRace{}
    conn = get conn, bicyclist_race_path(conn, :edit, bicyclist_race)
    assert html_response(conn, 200) =~ "Edit bicyclist race"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bicyclist_race = Repo.insert! %BicyclistRace{}
    conn = put conn, bicyclist_race_path(conn, :update, bicyclist_race), bicyclist_race: @valid_attrs
    assert redirected_to(conn) == bicyclist_race_path(conn, :show, bicyclist_race)
    assert Repo.get_by(BicyclistRace, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bicyclist_race = Repo.insert! %BicyclistRace{}
    conn = put conn, bicyclist_race_path(conn, :update, bicyclist_race), bicyclist_race: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bicyclist race"
  end

  test "deletes chosen resource", %{conn: conn} do
    bicyclist_race = Repo.insert! %BicyclistRace{}
    conn = delete conn, bicyclist_race_path(conn, :delete, bicyclist_race)
    assert redirected_to(conn) == bicyclist_race_path(conn, :index)
    refute Repo.get(BicyclistRace, bicyclist_race.id)
  end
end
