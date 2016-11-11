defmodule ContactDemo.Group do
  use ContactDemo.Web, :model

  schema "groups" do
    field :name, :string

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
    # TODO: Is there a regex to validate proper names?
  end
end
