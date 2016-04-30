defmodule Nested.UserRole do
  use Nested.Web, :model

  schema "users_roles" do
    belongs_to :user, Nested.User
    belongs_to :role, Nested.Role

    timestamps
  end

  @required_fields ~w(user_id role_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
