defmodule ContactDemo.Group do
  use ContactDemo.Web, :model

  alias ContactDemo.AppConstants

  schema "groups" do
    field :name, :string, null: false

    has_many :contacts_groups, ContactDemo.ContactGroup
    has_many :contacts, through: [:contacts_groups, :contact]

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(:name)
    |> validate_format(:name, AppConstants.name_format)
    |> validate_length(:name, min: 1, max: 255)
    |> unique_constraint(:name, name: :groups_name_index)
  end
end
