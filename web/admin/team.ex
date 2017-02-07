defmodule UphillRating.ExAdmin.Team do
  use ExAdmin.Register

  register_resource UphillRating.Team do
    index do
      selectable_column
      column :name
      actions [:edit, :delete]
    end

    show bicyclist_race do
      Phoenix.Controller.redirect conn, to: admin_resource_path(conn, :index)
    end
  end
end
