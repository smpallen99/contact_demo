# TODO: In a later version of Ecto, can we remove this? imo, it doesn't need to be exposed as a first-class model
defmodule ContactDemo.UserRole do
  use ContactDemo.Web, :model
  use Whatwasit

  schema "users_roles" do
    belongs_to :user, ContactDemo.User
    belongs_to :role, ContactDemo.Role

    timestamps
  end

  @required_fields ~w(user_id role_id)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    |> assoc_constraint(:user)
    |> assoc_constraint(:role)
    |> prepare_version(opts)
  end
end
