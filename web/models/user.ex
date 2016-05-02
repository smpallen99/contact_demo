defmodule ContactDemo.User do
  use ContactDemo.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :encrypted_password, :string
    field :active, :boolean, default: true
    field :expire_on, Ecto.Date

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :users_roles, ContactDemo.UserRole
    has_many :roles, through: [:users_roles, :role]
    timestamps
  end

  @required_fields ~w(name email active username)
  @optional_fields ~w(encrypted_password expire_on password password_confirmation)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> validate_password(params)
  end

  defp validate_password(changeset, :empty), do: changeset
  defp validate_password(changeset, params) do
    changeset
    |> validate_password_match(params)
    |> set_password(params)
  end
  defp validate_password_match(changeset, _params) do
    validate_change(changeset, :password, fn(:password, value) ->
      if value == changeset.changes[:password_confirmation], do: [],
        else: [{:password, {:must_match, :password_confirmation}}]
    end)
  end
  defp set_password(changeset, _params) do
    # Logger.debug "set_password: #{inspect changeset}"
    if changeset.valid? and not is_nil(changeset.changes[:password]) do
      put_change changeset, :encrypted_password,
        encrypt_password(changeset.changes[:password])
    else
      changeset
    end
  end

  def checkpw(password, encrypted) do
    try do
      Comeonin.Bcrypt.checkpw(password, encrypted)
    rescue
      _ -> false
    end
  end

  def encrypt_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

end
