defimpl ExAdmin.Authentication, for: Plug.Conn do
  alias Nested.Router.Helpers
  alias Nested.Authentication, as: Auth

  def use_authentication?(_), do: true
  def current_user(conn), do: Auth.current_user(conn)
  def current_user_name(conn), do: Auth.current_user(conn).name
  def session_path(conn, action), do: Helpers.session_path(conn, action)
end

defmodule Nested.Authentication do
  def current_user(conn) do
    PlugAuth.Authentication.Utils.get_authenticated_user(conn)
  end
end
