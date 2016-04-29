defmodule Nested.ContactGroup do
  use Nested.Web, :model

  schema "contacts_groups" do
    belongs_to :contact, Nested.Contact
    belongs_to :group, Nested.Group
  end

  @required_fields ~w(contact_id group_id)
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
