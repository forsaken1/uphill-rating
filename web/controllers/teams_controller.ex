defmodule UphillRating.TeamsController do
  use UphillRating.Web, :controller

  alias UphillRating.Team

  def show(conn, params) do
    team = Team |> Repo.get(params["id"]) |> Repo.preload(bicyclist_races: [:bicyclist, :race], bicyclists: [])
    render conn, "show.html", team: team
  end
end
