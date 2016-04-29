defmodule Nested.Contact do
  use Nested.Web, :model

  schema "contacts" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    belongs_to :category, Nested.Category
    has_many :contacts_groups, Nested.ContactGroup
    has_many :groups, through: [:contacts_groups, :groups]

    timestamps
  end

  @required_fields ~w(first_name last_name email)
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
