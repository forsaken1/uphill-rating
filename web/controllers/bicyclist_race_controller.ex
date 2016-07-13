defmodule UphillRating.BicyclistRaceController do
  use UphillRating.Web, :controller

  alias UphillRating.BicyclistRace

  plug :scrub_params, "bicyclist_race" when action in [:create, :update]

  def index(conn, _params) do
    bicyclist_races = Repo.all(BicyclistRace)
    render(conn, "index.html", bicyclist_races: bicyclist_races)
  end

  def new(conn, _params) do
    changeset = BicyclistRace.changeset(%BicyclistRace{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bicyclist_race" => bicyclist_race_params}) do
    changeset = BicyclistRace.changeset(%BicyclistRace{}, bicyclist_race_params)

    case Repo.insert(changeset) do
      {:ok, _bicyclist_race} ->
        conn
        |> put_flash(:info, "Bicyclist race created successfully.")
        |> redirect(to: bicyclist_race_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bicyclist_race = Repo.get!(BicyclistRace, id)
    render(conn, "show.html", bicyclist_race: bicyclist_race)
  end

  def edit(conn, %{"id" => id}) do
    bicyclist_race = Repo.get!(BicyclistRace, id)
    changeset = BicyclistRace.changeset(bicyclist_race)
    render(conn, "edit.html", bicyclist_race: bicyclist_race, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bicyclist_race" => bicyclist_race_params}) do
    bicyclist_race = Repo.get!(BicyclistRace, id)
    changeset = BicyclistRace.changeset(bicyclist_race, bicyclist_race_params)

    case Repo.update(changeset) do
      {:ok, bicyclist_race} ->
        conn
        |> put_flash(:info, "Bicyclist race updated successfully.")
        |> redirect(to: bicyclist_race_path(conn, :show, bicyclist_race))
      {:error, changeset} ->
        render(conn, "edit.html", bicyclist_race: bicyclist_race, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bicyclist_race = Repo.get!(BicyclistRace, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bicyclist_race)

    conn
    |> put_flash(:info, "Bicyclist race deleted successfully.")
    |> redirect(to: bicyclist_race_path(conn, :index))
  end
end
