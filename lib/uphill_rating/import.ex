defmodule Import do
  alias UphillRating.BicyclistRace
  alias UphillRating.Bicyclist
  alias UphillRating.Race
  alias UphillRating.Team
  alias UphillRating.Repo

  def process("BicyclistRace", row) do
    %BicyclistRace{
      time: time(row),
      bicyclist_id: bicyclist(row).id,
      race_id: race(row).id,
      team_id: team(row).id
    }
  end

  def process("Bicyclist", row) do
    %Bicyclist{
      name: Enum.at(row, 0),
      year: Enum.at(row, 1),
      sex: Enum.at(row, 2),
      team_id: team(row).id
    }
  end

  defp time(row) do
    Enum.at(row, 0) |> String.split([":", "."]) |> Enum.with_index |> Enum.map(fn {e, i} -> if i == 3 do String.to_integer(e) * 100000 else String.to_integer e end end) |> List.to_tuple |> Ecto.Time.cast |> elem(1)
  end

  defp bicyclist(row) do
    Bicyclist |> Repo.get_by! name: Enum.at(row, 1)
  end

  defp race(row) do
    Race |> Repo.get_by! name: Enum.at(row, 2)
  end

  defp team(row) do
    Team |> Repo.get_by! name: Enum.at(row, 3)
  end
end
