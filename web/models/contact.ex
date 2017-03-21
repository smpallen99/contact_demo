defmodule ContactDemo.Contact do
  use ContactDemo.Web, :model

  alias ContactDemo.AppConstants

  schema "contacts" do
    field :first_name, :string, null: false
    field :last_name, :string, null: false
    field :email, :string, null: false

    belongs_to :category, ContactDemo.Category
    #has_many :contacts_groups, ContactDemo.ContactGroup
    #has_many :groups, through: [:contacts_groups, :group]
    many_to_many :groups, ContactDemo.Group, join_through: ContactDemo.ContactGroup, on_replace: :delete

    #has_many :contacts_phone_numbers, ContactDemo.ContactPhoneNumber
    #has_many :phone_numbers, through: [:contacts_phone_numbers, :phone_number]

    many_to_many :phone_numbers, ContactDemo.PhoneNumber, join_through: ContactDemo.ContactPhoneNumber, on_replace: :delete

    timestamps
  end

  @required_fields ~w(first_name last_name email category_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    IO.inspect params
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_assoc(:category, required: false)
    |> add_groups(params)
    |> cast_assoc(:phone_numbers, required: false)
    |> validate_required([:first_name, :last_name, :email])
    |> validate_format(:first_name, AppConstants.name_format)
    |> validate_length(:first_name, min: 1, max: 255)
    |> validate_format(:last_name, AppConstants.name_format)
    |> validate_length(:last_name, min: 1, max: 255)
    |> validate_format(:email, AppConstants.email_format)
    |> validate_length(:email, min: 1, max: 255)
    |> assoc_constraint(:category)
    |> IO.inspect
  end

  def add_groups(changeset, params) do
    IO.inspect "params"
    IO.inspect params
    if Enum.count(Map.get(params, :groups, [])) > 1 do
      ids = params[:groups]
      IO.inspect "groups"
      IO.inspect ids
      groups = ContactDemo.Repo.all(from g in ContactDemo.Group, where: g.id in ^ids)
      put_assoc(changeset, :groups, groups)
    else
      changeset
    end
  end

end
