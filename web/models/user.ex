defmodule ContactDemo.User do
  use ContactDemo.Web, :model
  use Coherence.Schema
  use Whatwasit

  import Ecto.Query

  alias ContactDemo.{AppConstants, Role, UserRole}

  schema "users" do
    field :name, :string, null: false
    field :username, :string, null: false
    field :email, :string, null: false
    field :active, :boolean, null: false, default: true
    field :expire_on, Timex.Ecto.Date

    # handled by coherence
    # field :encrypted_password, :string
    # field :password, :string, virtual: true
    # field :password_confirmation, :string, virtual: true

    has_many :users_roles, UserRole
    has_many :roles, through: [:users_roles, :role]
    coherence_schema

    timestamps
  end


  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, ~w(name email username active expire_on) ++ coherence_fields)
    |> validate_required([:name, :email, :username, :active]) # TODO: Add 'expire_on'
    |> validate_format(:name, AppConstants.name_format)
    |> validate_length(:name, min: 1, max: 255)
    |> validate_format(:username, AppConstants.username_format)
    |> validate_length(:username, min: 1, max: 255)
    |> validate_length(:email, min: 1, max: 255)
    |> unique_constraint(:username, name: :users_username_index)
    |> validate_format(:email, AppConstants.email_format)
    |> unique_constraint(:email, name: :users_email_index)
    |> validate_coherence(params)
    |> prepare_version(opts)
  end

  def has_role?(model, role_name) do
    role_name = case is_atom(role_name) do
      true -> Atom.to_string(role_name)
      _ -> role_name
    end

    (from r in Role,
    join: ur in UserRole, on: ur.role_id == r.id,
    where: ur.user_id == ^model.id and fragment("LOWER(?)", r.name) == fragment("LOWER(?)", ^role_name),
    select: count(r.id))
    |> Repo.one > 0
  end
end
