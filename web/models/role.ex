defmodule ContactDemo.Role do
  use ContactDemo.Web, :model
  use Whatwasit

  alias ContactDemo.AppConstants

  schema "roles" do
    field :name, :string, null: false

    has_many :users_roles, ContactDemo.UserRole
    has_many :users, through: [:users_roles, :user]

    timestamps
  end

  @required_fields ~w(name)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    |> validate_format(:name, AppConstants.name_format)
    |> validate_length(:name, min: 1, max: 255)
    |> unique_constraint(:name, name: :roles_name_index)
    |> prepare_version(opts)
  end

  def admin, do: "Admin"
  # def technician, do: "Technician"
  # def front_office, do: "Front-office"
  # def dealer, do: "Dealer"
end
