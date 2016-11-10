defmodule ContactDemo.PageControllerTest do
  use ContactDemo.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Contact Demo!"
  end
end
