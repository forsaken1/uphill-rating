defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  alias UphillRating.Race

  def index(conn, _params) do
    races = Race |> Repo.all |> Repo.preload([:bicyclist_races, bicyclist_races: [:bicyclist] ])
    render conn, "index.html", races: races
  end

  def rating(conn, _params) do
    render conn, "rating.html"
  end
end
