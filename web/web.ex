defmodule ContactDemo.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use ContactDemo.Web, :controller
      use ContactDemo.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      alias ContactDemo.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2, where: 2, where: 3, preload: 3]

      def all, do: Repo.all(__MODULE__)
      def count, do: (from m in __MODULE__, select: count(m.id)) |> Repo.one # If we need more such aggregate functions, consider using ectoo
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias ContactDemo.Repo
      alias ContactDemo.Authentication, as: Auth
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import ContactDemo.Router.Helpers
      import ContactDemo.Gettext

      defp whodoneit(conn) do
        user = Auth.current_user(conn)
        [whodoneit: user, whodoneit_name: user.name]
      end
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ContactDemo.Router.Helpers
      import ContactDemo.ErrorHelpers
      import ContactDemo.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias ContactDemo.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
      import ContactDemo.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
