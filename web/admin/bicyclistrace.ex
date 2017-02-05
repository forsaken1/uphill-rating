defmodule UphillRating.ExAdmin.BicyclistRace do
  use ExAdmin.Register

  register_resource UphillRating.BicyclistRace do
    index do
      selectable_column
      column :bicyclist
      column :race
      column :place
      column :points
      column :time
      column :lag
    end

    form bicyclist_race do
      inputs do
        input bicyclist_race, :time, options: [sec: [] ]
        input bicyclist_race, :bicyclist, collection: UphillRating.Repo.all(UphillRating.Bicyclist)
        input bicyclist_race, :race, collection: UphillRating.Repo.all(UphillRating.Race)
        input bicyclist_race, :team, collection: UphillRating.Repo.all(UphillRating.Team)
      end
    end

    query do
      %{all: [preload: [:bicyclist, :race]]}
    end
  end
end
