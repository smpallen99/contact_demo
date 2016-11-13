defmodule ContactDemo.User do
  use ContactDemo.Web, :model
  use Coherence.Schema

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :active, :boolean, default: true
    field :expire_on, Timex.Ecto.Date

    # handled by coherence
    # field :encrypted_password, :string
    # field :password, :string, virtual: true
    # field :password_confirmation, :string, virtual: true

    has_many :users_roles, ContactDemo.UserRole
    has_many :roles, through: [:users_roles, :role]
    coherence_schema
    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email username active expire_on) ++ coherence_fields)
    |> validate_required([:name, :email, :username, :active]) # TODO: Add 'expire_on'
    # TODO: Is there a regex to validate proper names?
    # TODO: Validate max-length of string fields
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)   # TODO: This is an incorrect regex for email validation
    |> unique_constraint(:email)    # TODO: Not sure if this is handled by the 'validate_coherence'
    |> validate_coherence(params)
  end
end
