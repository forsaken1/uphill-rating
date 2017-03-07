defmodule UphillRating.TeamsController do
  use UphillRating.Web, :controller

  alias UphillRating.Team
  alias UphillRating.Bicyclist

  def show(conn, params) do
    team = Team |> Repo.get(params["id"]) |> Repo.preload(bicyclists: Bicyclist.order_by_name(Bicyclist), bicyclist_races: [:bicyclist, :race])
    render conn, "show.html", team: team
  end
end
