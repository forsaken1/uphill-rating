defmodule Calculate do
  alias UphillRating.Repo
  alias UphillRating.Race
  alias UphillRating.BicyclistRace

  @points [30, 27, 24, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6]

  def calculate_points_for(race) do
    bicyclist_races = BicyclistRace
      |> BicyclistRace.for_race(race)
      |> BicyclistRace.order_by_time
      |> Repo.all

    bicyclist_races_length = length(bicyclist_races)

    if bicyclist_races_length > 0 do
      winner = Enum.at bicyclist_races, 0
      
      for i <- 0..(bicyclist_races_length - 1) do
        bicyclist_race = Enum.at bicyclist_races, i
        points = calculate_points(i, bicyclist_races_length)
        {_, lag} = TimeHelper.diff(bicyclist_race.time, winner.time)

        Repo.update(
          BicyclistRace.changeset(
            bicyclist_race,
            %{
              place: i + 1,
              points: points,
              result_points: points * climb_coeff(race.climb),
              lag: lag
            }
          )
        )
      end
    end
  end

  def climb_coeff climb do
    if climb < 100 do
      Float.ceil((climb + 1) / 100.0, 1)
    else
      Float.floor(climb / 1000.0, 1) + 1
    end
  end

  def calculate_points position, count do
    if position > 19 do
      step = abs(5.0 / (count - 19))
      Float.round(1 + step * (count - position), 2)
    else
      Enum.at @points, position
    end
  end
end
