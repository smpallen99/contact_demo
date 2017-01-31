defmodule ContactDemo.User do
  use ContactDemo.Web, :model
  use Coherence.Schema

  alias ContactDemo.AppConstants
  alias ContactDemo.Repo
  alias ContactDemo.Role

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

    #has_many :users_roles, ContactDemo.UserRole
    #has_many :roles, through: [:users_roles, :role]
    #
    many_to_many :roles, ContactDemo.Role, join_through: ContactDemo.UserRole

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
    |> get_roles(params)
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
  end

  def get_roles(changeset, params) do
    if Enum.count(Map.get(params, :roles, [])) > 0 do
      roles = Repo.all(from r in Role, where: r.id in ^params[:roles])
      put_assoc(changeset, :roles, roles)
    else
      changeset
    end
  end
end
