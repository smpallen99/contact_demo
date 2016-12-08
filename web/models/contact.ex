defmodule ContactDemo.Contact do
  use ContactDemo.Web, :model
  use Whatwasit

  alias ContactDemo.AppConstants

  schema "contacts" do
    field :first_name, :string, null: false
    field :last_name, :string, null: false
    field :email, :string, null: false

    belongs_to :category, ContactDemo.Category
    has_many :contacts_groups, ContactDemo.ContactGroup
    has_many :groups, through: [:contacts_groups, :group]
    has_many :contacts_phone_numbers, ContactDemo.ContactPhoneNumber
    has_many :phone_numbers, through: [:contacts_phone_numbers, :phone_number]

    timestamps
  end

  @required_fields ~w(first_name last_name email category_id)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    |> validate_format(:first_name, AppConstants.name_format)
    |> validate_length(:first_name, min: 1, max: 255)
    |> validate_format(:last_name, AppConstants.name_format)
    |> validate_length(:last_name, min: 1, max: 255)
    |> validate_format(:email, AppConstants.email_format)
    |> validate_length(:email, min: 1, max: 255)
    |> assoc_constraint(:category)
    |> prepare_version(opts)
  end
end
