defmodule UphillRating.PageController do
  use UphillRating.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
