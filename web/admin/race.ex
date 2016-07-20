defmodule UphillRating.ExAdmin.Race do
  use ExAdmin.Register

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

      Phoenix.Controller.redirect conn, to: admin_resource_path(conn, :index)
    end
  end
end
