defmodule UphillRating.AdminController do
  use UphillRating.Web, :controller

  alias UphillRating.Repo

  def import(conn, params) do
    flash_message = "Import complete"
    file_path = params["import"]["file"].path
    resource = params["import"]["resource"]

    if File.regular?(file_path) do
      File.stream!(file_path)
      |> CSV.decode(separator: ?;)
      |> Enum.map(fn row -> Repo.insert! Import.process(resource, row) end)
    end

    Phoenix.Controller.put_flash(conn, :notice, flash_message)
    |> Phoenix.Controller.redirect(to: ExAdmin.Utils.admin_resource_path(UphillRating.BicyclistRace, :index))
  end
end
