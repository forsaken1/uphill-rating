defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  alias UphillRating.BicyclistRace

  def index(conn, _params) do
    bicyclist_races = BicyclistRace |> Repo.all |> Repo.preload([:bicyclist])
    render conn, "index.html", bicyclist_races: bicyclist_races
  end

  def rating(conn, _params) do
    render conn, "rating.html"
  end
end
