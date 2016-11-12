defmodule ContactDemo.Role do
  use ContactDemo.Web, :model

  schema "roles" do
    field :name, :string

    has_many :users_roles, ContactDemo.UserRole
    has_many :users, through: [:users_roles, :user]

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(:name)
    # TODO: Is there a regex to validate proper names?
  end
end
