defmodule ContactDemo.SessionController do
  use ContactDemo.Web, :controller
  alias ContactDemo.User
  require Logger

  def new(conn, _params) do
    render conn, :new, [username: ""]
  end

  def create(conn, params) do
    Logger.warn "params: #{inspect params}"
    username = params["session"]["username"]
    password = params["session"]["password"]
    u = Repo.one(from u in User, where: u.username == ^username)
    Logger.warn "user: #{inspect u}"
    if u != nil and User.checkpw(password, u.encrypted_password) do
      url = case get_session(conn, "user_return_to") do
        nil -> "/"
        value -> value
      end
      conn
      |> PlugAuth.Authentication.Database.create_login(u, :name)
      |> put_flash(:notice, "Signed in successfully.")
      |> put_session("user_return_to", nil)
      |> redirect(to: url)
    else
      render(conn, :new, [username: username])
    end
  end

  def destroy(conn, _params) do
    PlugAuth.Authentication.Database.delete_login(conn)
    |> redirect(to: session_path(conn, :new))
  end

  def login_callback(conn) do
    conn
    |> put_layout({ContactDemo.LayoutView, "app.html"})
    |> put_view(ContactDemo.SessionView)
    |> render("new.html", username: "")
    |> halt
  end
end
