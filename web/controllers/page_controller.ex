defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  alias UphillRating.Race
  alias UphillRating.Bicyclist
  alias UphillRating.BicyclistRace

  def index(conn, _params) do
    races = Race |> Repo.all |> Repo.preload([:bicyclist_races, bicyclist_races: [:team, :bicyclist] ])
    render conn, "index.html", races: races
  end

  def rating(conn, _params) do
    # bicyclist_races = Repo.all(
    #   from br in BicyclistRace,
    #     join: b in assoc(br, :bicyclist),
    #     group_by: b.name,
    #     order_by: [desc: sum(br.points)],
    #     select: { b.name, sum(br.points) }
    # )
    bicyclists = Bicyclist |> Repo.all |> Repo.preload([:bicyclist_races])
    races = Race |> Repo.all
    # require IEx
    # IEx.pry
    render conn, "rating.html", bicyclists: bicyclists, races: races
  end

  def rating_teams(conn, _params) do
    render conn, "rating_teams.html"
  end
end
