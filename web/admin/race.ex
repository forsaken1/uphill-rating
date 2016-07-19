defmodule UphillRating.ExAdmin.Race do
  use ExAdmin.Register

  register_resource UphillRating.Race do
    member_action :calculate, &__MODULE__.calculate_action/2

    def calculate_action conn, params do
      redirect to: "/"
    end
  end
end
