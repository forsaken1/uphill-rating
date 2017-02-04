defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  import Ecto.Query

  alias UphillRating.Team
  alias UphillRating.Race
  alias UphillRating.Bicyclist
  alias UphillRating.BicyclistRace

  def index(conn, _params) do
    races = Race |> Repo.all |> Repo.preload(bicyclist_races: BicyclistRace.ordered(BicyclistRace), bicyclist_races: [bicyclist: :team])
    render conn, "index.html", races: races
  end

  def rating(conn, _params) do
    bicyclists = Repo.all from b in Bicyclist,
      join: br in assoc(b, :bicyclist_races),
      select: %{id: b.id, name: b.name, points: sum(br.result_points)},
      group_by: b.id,
      order_by: [desc: sum(br.result_points)]
    bicyclist_ids = Enum.map bicyclists, fn (e) -> e[:id] end
    bicyclist_races = BicyclistRace |> where([b], b.id in ^bicyclist_ids) |> Repo.all
    races = Race |> Repo.all
    render conn, "rating.html", bicyclists: bicyclists, races: races, bicyclist_races: bicyclist_races
  end

  def rating_teams(conn, _params) do
    teams = Team |> Repo.all |> Repo.preload(bicyclists: [:bicyclist_races])
    races = Race |> Repo.all
    render conn, "rating_teams.html", teams: teams, races: races
  end
end
