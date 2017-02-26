defmodule Import do
  alias UphillRating.BicyclistRace
  alias UphillRating.Bicyclist
  alias UphillRating.Race
  alias UphillRating.Team
  alias UphillRating.Repo

  def process_file(resource, file_path) do
    status = :ok
    messages = []
    data = File.stream!(file_path)
    |> CSV.decode(separator: ?;)
    |> Enum.with_index
    |> Enum.map(fn {row, i} ->
      {st, obj, message} = process(resource, row)
      if st != :ok do
        status = :error
        messages = [messages | "Error on line #{i + 1}: #{message}"]
      end
      obj
    end)
    {status, data, messages}
  end

  defp process("BicyclistRace", row) do
    time = time(row |> Enum.at 0)
    bicyclist_name = row |> Enum.at 1
    race_name = row |> Enum.at 2
    team_name = row |> Enum.at 3

    unless bicyclist = bicyclist(bicyclist_name) do
      {:error, nil, "bicyclist \"#{bicyclist_name}\" not exist"}
    else
      unless race = race(race_name) do
        {:error, nil, "race \"#{race_name}\" not exist"}
      else
        unless team = team(team_name) do
          {:error, nil, "team \"#{team_name}\" not exist"}
        else
          obj = %BicyclistRace{
            time: time,
            bicyclist_id: bicyclist.id,
            race_id: race.id,
            team_id: team.id
          }
          {:ok, obj, nil}
        end
      end
    end
  end

  defp process("Bicyclist", row) do
    team_name = Enum.at(row, 3)

    unless team = team(team_name) do
      {:error, nil, "team \"#{team_name}\" not exist"}
    else
      obj = %Bicyclist{
        name: Enum.at(row, 0),
        year: Enum.at(row, 1),
        sex: Enum.at(row, 2),
        team_id: team.id
      }
      {:ok, obj, nil}
    end
  end

  defp time(raw_time) do
    raw_time |> String.split([":", "."]) |> Enum.with_index |> Enum.map(fn {e, i} -> if i == 3 do String.to_integer(e) * 100000 else String.to_integer e end end) |> List.to_tuple |> Ecto.Time.cast |> elem(1)
  end

  defp bicyclist(name) do
    Bicyclist |> Repo.get_by name: name
  end

  defp race(name) do
    Race |> Repo.get_by name: name
  end

  defp team(name) do
    Team |> Repo.get_by name: name
  end
end
