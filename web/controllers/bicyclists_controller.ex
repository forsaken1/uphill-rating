defmodule UphillRating.BicyclistsController do
  use UphillRating.Web, :controller

  alias UphillRating.Bicyclist

  def show(conn, params) do
    bicyclist = Bicyclist |> Repo.get(params["id"]) |> Repo.preload(bicyclist_races: [:team, :race])
    render conn, "show.html", bicyclist: bicyclist
  end
end
