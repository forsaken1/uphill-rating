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

    filter [:name, :year, :sex]

    query do
      %{all: [preload: [:team]]}
    end

    sidebar :Import do
      form_tag("/admin/bicyclist_races/import", multipart: true) do
        Phoenix.HTML.raw("
          <input type=\"hidden\" name=\"import[resource]\" value=\"Bicyclist\">
          <div class=\"box-body\">
            <input type=\"file\" name=\"import[file]\">
          </div>
          <div class=\"box-footer\">
            <button class=\"btn btn-primary\" type=\"submit\">Import</button>
          </div>
        ")
      end
    end
  end
end
