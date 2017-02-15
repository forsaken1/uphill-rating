defmodule Filter do
  def index(bicyclist_race, attrs) do
    bicyclist_id = Keyword.get attrs, :bicyclist_id
    team_id = Keyword.get attrs, :team_id
    (!bicyclist_id || bicyclist_id == "" || String.to_integer(bicyclist_id) == bicyclist_race.bicyclist_id) &&
      (!team_id || team_id == "" || String.to_integer(team_id) == bicyclist_race.team_id)
  end
end