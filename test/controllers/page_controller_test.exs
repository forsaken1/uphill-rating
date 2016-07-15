defmodule UphillRating.PageControllerTest do
  use UphillRating.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Рейтинг апхилов"
  end
end
