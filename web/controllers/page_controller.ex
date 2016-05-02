defmodule ContactDemo.PageController do
  use ContactDemo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
