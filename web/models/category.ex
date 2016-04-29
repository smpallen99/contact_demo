defmodule Nested.Category do
  use Nested.Web, :model

  schema "categories" do
    field :name, :string
    field :position, :integer
    has_many :contacts, Nested.Contact

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(position)

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
