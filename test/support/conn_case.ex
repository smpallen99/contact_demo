defmodule ContactDemo.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox
  alias ContactDemo.Repo
  alias Phoenix.ConnTest

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias ContactDemo.{Endpoint, Repo, User}
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      import ContactDemo.Router.Helpers

      import ContactDemo.Factory

      # The default endpoint for testing
      @endpoint Endpoint

      setup do
        conn = build_conn |> assign(:current_user, %User{name: "System User for tests"})
        %{conn: conn}
      end
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async], do: Sandbox.mode(Repo, {:shared, self()})

    {:ok, conn: ConnTest.build_conn()}
  end
end
