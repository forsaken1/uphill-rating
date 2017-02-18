defmodule UphillRating.ExAdmin.Race do
  use ExAdmin.Register
  alias UphillRating.Repo
  alias UphillRating.Race

  register_resource UphillRating.Race do
    index do
      selectable_column
      column :name
      column :climb
      column :date
    end

    form race do
      inputs do
        input race, :name
        input race, :date
        input race, :climb
        input race, :information, type: :text
      end
    end

    filter [:name, :climb, :date]

    member_action :calculate, &__MODULE__.calculate_action/2

    def calculate_action conn, params do
      race = Repo.get! Race, params[:id]

      Calculate.calculate_points_for race

      Phoenix.Controller.put_flash(conn, :notice, "Calculation complete")
      |> Phoenix.Controller.redirect to: admin_resource_path(conn, :index)
    end
  end
end
