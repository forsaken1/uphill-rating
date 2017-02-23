defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  import Ecto.Query

  alias UphillRating.Team
  alias UphillRating.Race
  alias UphillRating.Bicyclist
  alias UphillRating.BicyclistRace

  def index(conn, params) do
    year = year(params)
    races = Race |> Race.by_year(year) |> order_by(desc: :date) |> Repo.all |> Repo.preload(bicyclist_races: BicyclistRace.order_by_points(BicyclistRace), bicyclist_races: [:team, :bicyclist])
    bicyclists = Bicyclist |> Repo.all
    teams = Team |> Repo.all
    render conn, "index.html", races: races, bicyclists: bicyclists, teams: teams, year: year, bicyclist_id: bicyclist_id(params), team_id: team_id(params)
  end

  def rating(conn, params) do
    year = year(params)
    bicyclists = Repo.all from b in Bicyclist,
      join: br in assoc(b, :bicyclist_races),
      join: r in assoc(br, :race),
      select: %{id: b.id, name: b.name, points: sum(br.result_points)},
      where: r.date >= ^date_from(year) and r.date <= ^date_to(year),
      group_by: b.id,
      order_by: [desc: sum(br.result_points)]
    bicyclist_ids = Enum.map bicyclists, fn (e) -> e[:id] end
    bicyclist_races = BicyclistRace |> where([br], br.bicyclist_id in ^bicyclist_ids) |> Repo.all
    races = Race |> Race.by_year(year) |> order_by(asc: :date) |> Repo.all
    render conn, "rating.html", bicyclists: bicyclists, races: races, bicyclist_races: bicyclist_races, year: year
  end

  def rating_teams(conn, params) do
    year = year(params)
    teams = Repo.all from t in Team,
      join: br in assoc(t, :bicyclist_races),
      join: r in assoc(br, :race),
      select: %{id: t.id, name: t.name, points: sum(br.result_points)},
      where: r.date >= ^date_from(year) and r.date <= ^date_to(year),
      group_by: t.id,
      order_by: [desc: sum(br.result_points)]
    team_ids = Enum.map teams, fn (e) -> e[:id] end
    bicyclist_races = BicyclistRace |> where([br], br.team_id in ^team_ids) |> Repo.all
    bicyclist_ids = Enum.map bicyclist_races, fn (e) -> e.bicyclist_id end
    bicyclists = Bicyclist |> where([b], b.id in ^bicyclist_ids) |> Repo.all
    races = Race |> Race.by_year(year) |> order_by(asc: :date) |> Repo.all
    render conn, "rating_teams.html", teams: teams, races: races, year: year, bicyclist_races: bicyclist_races, bicyclists: bicyclists
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

  defp date_from(year) do
    {_, from} = Ecto.Date.cast({year, 1, 1})
    from
  end

  defp date_to(year) do
    {_, to} = Ecto.Date.cast({year, 12, 31})
    to
  end
end
