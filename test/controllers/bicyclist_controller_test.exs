defmodule UphillRating.BicyclistControllerTest do
  use UphillRating.ConnCase

  alias UphillRating.Bicyclist
  @valid_attrs %{name: "some content", sex: "some content", year: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bicyclist_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bicyclists"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bicyclist_path(conn, :new)
    assert html_response(conn, 200) =~ "New bicyclist"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bicyclist_path(conn, :create), bicyclist: @valid_attrs
    assert redirected_to(conn) == bicyclist_path(conn, :index)
    assert Repo.get_by(Bicyclist, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bicyclist_path(conn, :create), bicyclist: @invalid_attrs
    assert html_response(conn, 200) =~ "New bicyclist"
  end

  test "shows chosen resource", %{conn: conn} do
    bicyclist = Repo.insert! %Bicyclist{}
    conn = get conn, bicyclist_path(conn, :show, bicyclist)
    assert html_response(conn, 200) =~ "Show bicyclist"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bicyclist_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bicyclist = Repo.insert! %Bicyclist{}
    conn = get conn, bicyclist_path(conn, :edit, bicyclist)
    assert html_response(conn, 200) =~ "Edit bicyclist"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bicyclist = Repo.insert! %Bicyclist{}
    conn = put conn, bicyclist_path(conn, :update, bicyclist), bicyclist: @valid_attrs
    assert redirected_to(conn) == bicyclist_path(conn, :show, bicyclist)
    assert Repo.get_by(Bicyclist, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bicyclist = Repo.insert! %Bicyclist{}
    conn = put conn, bicyclist_path(conn, :update, bicyclist), bicyclist: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bicyclist"
  end

  test "deletes chosen resource", %{conn: conn} do
    bicyclist = Repo.insert! %Bicyclist{}
    conn = delete conn, bicyclist_path(conn, :delete, bicyclist)
    assert redirected_to(conn) == bicyclist_path(conn, :index)
    refute Repo.get(Bicyclist, bicyclist.id)
  end
end
