defmodule UphillRating.ExAdmin.Race do
  use ExAdmin.Register
  alias UphillRating.Repo
  alias UphillRating.Race
  alias UphillRating.BicyclistRace

  register_resource UphillRating.Race do
    index do
      selectable_column
      column :id
      column :name
    end

    form race do
      inputs do
        input race, :name
        input race, :information, type: :text
        input race, :climb
      end
    end

    member_action :calculate, &__MODULE__.calculate_action/2

    def calculate_action conn, params do
      race = Repo.get! Race, params[:id]
      bicyclist_races = BicyclistRace
        |> BicyclistRace.for_race(race)
        |> BicyclistRace.sorted
        |> Repo.all

      bicyclist_races_length = length(bicyclist_races)

      for i <- 0..(bicyclist_races_length - 1) do
        points = calculate_points(i, bicyclist_races_length)
        Repo.update(
          BicyclistRace.changeset(
            Enum.at(bicyclist_races, i),
            %{place: i + 1, points: points, result_points: points * Race.climb_coeff(race.climb)}
          )
        )
      end
      Phoenix.Controller.redirect conn, to: admin_resource_path(conn, :index)
    end

    @points [30, 27, 24, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6]

    def calculate_points i, count do
      if i > 20 do
        step = 5.0 / count - 19
        1 + step * (count - i)
      else
        Enum.at @points, i
      end
    end
  end
end
