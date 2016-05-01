defmodule Nested.User do
  use Nested.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string
    field :active, :boolean, default: true
    field :expire_on, Ecto.Date

    has_many :users_roles, Nested.UserRole
    has_many :roles, through: [:users_roles, :role]
    timestamps
  end

  @required_fields ~w(name email active)
  @optional_fields ~w(encrypted_password expire_on)

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
