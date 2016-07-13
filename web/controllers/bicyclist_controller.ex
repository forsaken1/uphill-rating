defmodule UphillRating.BicyclistController do
  use UphillRating.Web, :controller

  alias UphillRating.Bicyclist

  plug :scrub_params, "bicyclist" when action in [:create, :update]

  def index(conn, _params) do
    bicyclists = Repo.all(Bicyclist)
    render(conn, "index.html", bicyclists: bicyclists)
  end

  def new(conn, _params) do
    changeset = Bicyclist.changeset(%Bicyclist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bicyclist" => bicyclist_params}) do
    changeset = Bicyclist.changeset(%Bicyclist{}, bicyclist_params)

    case Repo.insert(changeset) do
      {:ok, _bicyclist} ->
        conn
        |> put_flash(:info, "Bicyclist created successfully.")
        |> redirect(to: bicyclist_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bicyclist = Repo.get!(Bicyclist, id)
    render(conn, "show.html", bicyclist: bicyclist)
  end

  def edit(conn, %{"id" => id}) do
    bicyclist = Repo.get!(Bicyclist, id)
    changeset = Bicyclist.changeset(bicyclist)
    render(conn, "edit.html", bicyclist: bicyclist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bicyclist" => bicyclist_params}) do
    bicyclist = Repo.get!(Bicyclist, id)
    changeset = Bicyclist.changeset(bicyclist, bicyclist_params)

    case Repo.update(changeset) do
      {:ok, bicyclist} ->
        conn
        |> put_flash(:info, "Bicyclist updated successfully.")
        |> redirect(to: bicyclist_path(conn, :show, bicyclist))
      {:error, changeset} ->
        render(conn, "edit.html", bicyclist: bicyclist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bicyclist = Repo.get!(Bicyclist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bicyclist)

    conn
    |> put_flash(:info, "Bicyclist deleted successfully.")
    |> redirect(to: bicyclist_path(conn, :index))
  end
end
