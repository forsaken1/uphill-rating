defmodule UphillRating.Repo do
  use Ecto.Repo, otp_app: :uphill_rating
  use Scrivener, page_size: 10
end
