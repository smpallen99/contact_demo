defmodule ContactDemo.Contact do
  use ContactDemo.Web, :model

  schema "contacts" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    belongs_to :category, ContactDemo.Category
    has_many :contacts_groups, ContactDemo.ContactGroup
    has_many :groups, through: [:contacts_groups, :group]
    has_many :contacts_phone_numbers, ContactDemo.ContactPhoneNumber
    has_many :phone_numbers, through: [:contacts_phone_numbers, :phone_number]

    timestamps
  end

  @required_fields ~w(first_name last_name email category_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
