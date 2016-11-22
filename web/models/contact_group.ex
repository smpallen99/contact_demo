defmodule ContactDemo.ContactGroup do
  use ContactDemo.Web, :model
  use Whatwasit

  schema "contacts_groups" do
    belongs_to :contact, ContactDemo.Contact
    belongs_to :group, ContactDemo.Group

    timestamps
  end

  @required_fields ~w(contact_id group_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:contact)
    |> assoc_constraint(:group)
    |> prepare_version(opts)
  end
end
