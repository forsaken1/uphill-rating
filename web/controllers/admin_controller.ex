defmodule UphillRating.AdminController do
  use UphillRating.Web, :controller

  alias UphillRating.Repo

  def import(conn, params) do
    flash_message = "Unknown error" 
    
    if params["import"]["file"] do
      file_path = params["import"]["file"].path
      resource = params["import"]["resource"]

      if File.regular?(file_path) do
        {status, prepared_data, messages} = Import.process_file(resource, file_path)
        if status == :ok do
          prepared_data |> Enum.map(fn e -> Repo.insert e end)
        end
        flash_message = messages |> Enum.join("\n")
      end
    else
      flash_message = "File not selected"
    end

    Phoenix.Controller.put_flash(conn, :notice, flash_message |> Phoenix.HTML.Format.text_to_html |> Phoenix.HTML.safe_to_string)
    |> Phoenix.Controller.redirect(to: ExAdmin.Utils.admin_resource_path(UphillRating.BicyclistRace, :index))
  end
end
