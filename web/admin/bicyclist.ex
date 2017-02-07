defmodule UphillRating.ExAdmin.Bicyclist do
  use ExAdmin.Register

  register_resource UphillRating.Bicyclist do
    index do
      selectable_column
      column :name
      column :team
      column :sex
      column :year
    end

    form bicycle do
      inputs do
        input bicycle, :name
        input bicycle, :year
        input bicycle, :sex, collection: [ "Male", "Female" ]
        input bicycle, :team, collection: UphillRating.Repo.all(UphillRating.Team)
      end
    end

    show bicyclist_race do
      Phoenix.Controller.redirect conn, to: admin_resource_path(conn, :index)
    end

    query do
      %{all: [preload: [:team]]}
    end
  end
end
