defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  import Ecto.Query

  alias UphillRating.Team
  alias UphillRating.Race
  alias UphillRating.Bicyclist
  alias UphillRating.BicyclistRace

  def index(conn, params) do
    year = year(params)
    races = Race |> Race.by_year(year) |> Repo.all |> Repo.preload(bicyclist_races: BicyclistRace.order_by_points(BicyclistRace), bicyclist_races: [:team, :bicyclist])
    bicyclists = Bicyclist |> Repo.all
    teams = Team |> Repo.all
    render conn, "index.html", races: races, bicyclists: bicyclists, teams: teams, year: year, bicyclist_id: bicyclist_id(params), team_id: team_id(params)
  end

  def rating(conn, params) do
    year = year(params)
    {_, from} = Ecto.Date.cast({year, 1, 1})
    {_, to} = Ecto.Date.cast({year, 12, 31})
    bicyclists = Repo.all from b in Bicyclist,
      join: br in assoc(b, :bicyclist_races),
      join: r in assoc(br, :race),
      select: %{id: b.id, name: b.name, points: sum(br.result_points)},
      where: r.date >= ^from and r.date <= ^to,
      group_by: b.id,
      order_by: [desc: sum(br.result_points)]
    bicyclist_ids = Enum.map bicyclists, fn (e) -> e[:id] end
    bicyclist_races = BicyclistRace |> where([br], br.bicyclist_id in ^bicyclist_ids) |> Repo.all
    races = Race |> Race.by_year(year(params)) |> Repo.all
    render conn, "rating.html", bicyclists: bicyclists, races: races, bicyclist_races: bicyclist_races, year: year
  end

  def rating_teams(conn, _params) do
    teams = Team |> Repo.all |> Repo.preload(bicyclists: [:bicyclist_races])
    races = Race |> Repo.all
    render conn, "rating_teams.html", teams: teams, races: races
  end

  def about(conn, _params) do
    render conn, "about.html"
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

  defp team_id(params) do
    filter(params) && Map.get(filter(params), "team_id")
  end
end
