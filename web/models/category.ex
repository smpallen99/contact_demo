defmodule ContactDemo.Category do
  use ContactDemo.Web, :model

  alias ContactDemo.AppConstants

  schema "categories" do
    field :name, :string, null: false
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
    |> validate_format(:name, AppConstants.name_format)
    # TODO: Should position always be positive?
    # TODO: Should position be unique?
    |> validate_length(:name, min: 1, max: 255)
  end
end
