defmodule ContactDemo.Category do
  use ContactDemo.Web, :model
  use Whatwasit

  alias ContactDemo.AppConstants

  schema "categories" do
    field :name, :string, null: false
    field :position, :integer

    has_many :contacts, ContactDemo.Contact

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(position)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    |> validate_format(:name, AppConstants.name_format)
    # TODO: Should position always be positive?
    # TODO: Should position be unique?
    |> validate_length(:name, min: 1, max: 255)
    |> prepare_version(opts)
  end
end
