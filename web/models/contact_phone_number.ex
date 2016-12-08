# TODO: In a later version of Ecto, can we remove this? imo, it doesn't need to be exposed as a first-class model
defmodule ContactDemo.ContactPhoneNumber do
  use ContactDemo.Web, :model
  use Whatwasit

  schema "contacts_phone_numbers" do
    belongs_to :contact, ContactDemo.Contact
    belongs_to :phone_number, ContactDemo.PhoneNumber

    timestamps
  end

  @required_fields ~w(contact_id phone_number_id)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    |> assoc_constraint(:contact)
    |> assoc_constraint(:phone_number)
    |> prepare_version(opts)
  end
end
