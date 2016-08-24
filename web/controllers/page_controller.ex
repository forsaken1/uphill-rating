defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  alias UphillRating.Team
  alias UphillRating.Race
  alias UphillRating.Bicyclist
  alias UphillRating.BicyclistRace

  def index(conn, _params) do
    races = Race |> Repo.all# |> Repo.preload([bicyclist_races: [bicyclist: [:team]] ])
    render conn, "index.html", races: races
  end

  def rating(conn, _params) do
    bicyclists = Bicyclist |> Repo.all |> Repo.preload([:bicyclist_races])
    races = Race |> Repo.all
    render conn, "rating.html", bicyclists: bicyclists, races: races
  end

  def rating_teams(conn, _params) do
    teams = Team |> Repo.all |> Repo.preload([:bicyclist_races])
    races = Race |> Repo.all
    render conn, "rating_teams.html", teams: teams, races: races
  end
end
