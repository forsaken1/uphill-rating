defmodule UphillRating.ExAdmin.Team do
  use ExAdmin.Register

  register_resource UphillRating.Team do
    index do
      selectable_column
      column :name
    end
  end
end
