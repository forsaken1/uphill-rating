defmodule UphillRating.AdminController do
  use UphillRating.Web, :controller

  import Ecto.Query

  alias UphillRating.BicyclistRace
  alias UphillRating.Bicyclist
  alias UphillRating.Race
  alias UphillRating.Team

  def import(conn, params) do
    flash_message = "Import complete"
    file_path = params["import"]["file"].path

    if File.regular?(file_path) do
      File.stream!(file_path) |> CSV.decode(separator: ?;) |> Enum.map(fn row ->
        Repo.insert! %BicyclistRace{
          time: time(row),
          bicyclist_id: bicyclist(row).id,
          race_id: race(row).id,
          team_id: team(row).id
        }
      end)
    end

    Phoenix.Controller.put_flash(conn, :notice, flash_message)
    |> Phoenix.Controller.redirect(to: ExAdmin.Utils.admin_resource_path(UphillRating.BicyclistRace, :index))
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
