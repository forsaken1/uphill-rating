defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  import Ecto.Query

  require IEx

  alias UphillRating.Team
  alias UphillRating.Race
  alias UphillRating.Bicyclist
  alias UphillRating.BicyclistRace

  def index(conn, params) do
    races = Race |> Race.by_year(year(params)) |> Repo.all |> Repo.preload(bicyclist_races: BicyclistRace.order_by_points(BicyclistRace), bicyclist_races: [bicyclist: :team])
    bicyclists = Bicyclist |> Repo.all
    bicyclist_id = bicyclist_id(params)
    render conn, "index.html", races: races, bicyclists: bicyclists, bicyclist_id: bicyclist_id
  end

  def rating(conn, _params) do
    bicyclists = Repo.all from b in Bicyclist,
      join: br in assoc(b, :bicyclist_races),
      select: %{id: b.id, name: b.name, points: sum(br.result_points)},
      group_by: b.id,
      order_by: [desc: sum(br.result_points)]
    bicyclist_ids = Enum.map bicyclists, fn (e) -> e[:id] end
    bicyclist_races = BicyclistRace |> where([br], br.bicyclist_id in ^bicyclist_ids) |> Repo.all
    races = Race |> Repo.all
    render conn, "rating.html", bicyclists: bicyclists, races: races, bicyclist_races: bicyclist_races
  end

  def rating_teams(conn, _params) do
    teams = Team |> Repo.all |> Repo.preload(bicyclists: [:bicyclist_races])
    races = Race |> Repo.all
    render conn, "rating_teams.html", teams: teams, races: races
  end

  defp filter(params) do
    Map.get params, "filter"
  end

  defp year(params) do
    filter(params) && Map.get(filter(params), "year") || 2016
  end

  defp bicyclist_id(params) do
    filter(params) && Map.get(filter(params), "bicyclist_id")
  end
end
