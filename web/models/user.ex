defmodule ContactDemo.User do
  use ContactDemo.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :username, :string
    # field :email, :string
    # field :encrypted_password, :string
    field :active, :boolean, default: true
    field :expire_on, Ecto.Date

    # field :password, :string, virtual: true
    # field :password_confirmation, :string, virtual: true

    has_many :users_roles, ContactDemo.UserRole
    has_many :roles, through: [:users_roles, :role]
    coherence_schema
    timestamps
  end

  @required_fields ~w(name email active username)
  @optional_fields ~w(encrypted_password expire_on password password_confirmation)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(username active expire_on) ++ coherence_fields)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> validate_coherence(params)
  end

end
