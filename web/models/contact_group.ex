# TODO: In a later version of Ecto, can we remove this? imo, it doesn't need to be exposed as a first-class model
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

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:contact)
    |> assoc_constraint(:group)
    |> prepare_version(opts)
  end
end
