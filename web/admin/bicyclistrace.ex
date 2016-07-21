defmodule UphillRating.ExAdmin.BicyclistRace do
  use ExAdmin.Register

  register_resource UphillRating.BicyclistRace do
    form bicyclist_race do
      inputs do
        input bicyclist_race, :time, options: [sec: [] ]
        input bicyclist_race, :lag, options: [sec: [] ]
        input bicyclist_race, :bicyclist, collection: UphillRating.Repo.all(UphillRating.Bicyclist)
        input bicyclist_race, :team, collection: UphillRating.Repo.all(UphillRating.Team)
        input bicyclist_race, :race, collection: UphillRating.Repo.all(UphillRating.Race)
      end
    end

    query do
      %{all: [preload: [:bicyclist, :race, :team]]}
    end
  end
end
