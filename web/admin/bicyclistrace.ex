defmodule UphillRating.ExAdmin.BicyclistRace do
  use ExAdmin.Register

  register_resource UphillRating.BicyclistRace do
    index do
      selectable_column
      column :bicyclist
      column :race
      column :place
      column :points
      column :time, fn(bicyclist_race) ->
        TimeHelper.time_with_mc bicyclist_race.time
      end
      column :lag
      actions [:edit, :delete]
    end

    form bicyclist_race do
      inputs do
        input bicyclist_race, :time, options: [sec: [], usec: [options: usec_options]]
        input bicyclist_race, :bicyclist, collection: UphillRating.Repo.all(UphillRating.Bicyclist)
        input bicyclist_race, :race, collection: UphillRating.Repo.all(UphillRating.Race)
        input bicyclist_race, :team, collection: UphillRating.Repo.all(UphillRating.Team)
      end
    end

    show bicyclist_race do
      Phoenix.Controller.redirect conn, to: admin_resource_path(conn, :index)
    end

    query do
      %{all: [preload: [:bicyclist, :race, :team]]}
    end

    defp usec_options do
      Enum.to_list(0..99)
      |> Enum.map(fn(i) -> {String.to_atom(Integer.to_string(i)), Integer.to_string(i) <> "0000"} end)
      |> Keyword.new
    end
  end
end
