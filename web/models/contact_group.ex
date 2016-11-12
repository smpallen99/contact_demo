defmodule ContactDemo.ContactGroup do
  use ContactDemo.Web, :model

  schema "contacts_groups" do
    belongs_to :contact, ContactDemo.Contact
    belongs_to :group, ContactDemo.Group
  end

  @required_fields ~w(contact_id group_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:contact_id)
    |> foreign_key_constraint(:group_id)
  end
end
