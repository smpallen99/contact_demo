defmodule ContactDemo.ContactPhoneNumber do
  use ContactDemo.Web, :model
  use Whatwasit

  schema "contacts_phone_numbers" do
    belongs_to :contact, ContactDemo.Contact
    belongs_to :phone_number, ContactDemo.PhoneNumber

    timestamps
  end

  @required_fields ~w(contact_id phone_number_id)
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
    |> assoc_constraint(:phone_number)
    |> prepare_version(opts)
  end
end
