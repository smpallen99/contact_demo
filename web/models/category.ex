defmodule ContactDemo.Category do
  use ContactDemo.Web, :model

  schema "categories" do
    field :name, :string
    field :position, :integer
    has_many :contacts, ContactDemo.Contact

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(position)

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
    # TODO: Should position always be positive?
    # TODO: Should position be unique?
    # TODO: Validate max-length of string fields
  end
end
