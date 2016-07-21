defmodule UphillRating.ExAdmin.Bicyclist do
  use ExAdmin.Register

  register_resource UphillRating.Bicyclist do
    form bicycle do
      inputs do
        input bicycle, :name
        input bicycle, :year
        input bicycle, :sex, collection: [ "Male", "Female" ]
      end
    end
  end
end
