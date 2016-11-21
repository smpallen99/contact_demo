defmodule ContactDemo.PhoneNumber do
  use ContactDemo.Web, :model
  use Whatwasit

  alias __MODULE__
  alias ContactDemo.Repo

  schema "phone_numbers" do
    field :number, :string, null: false
    field :kind, :string    # TODO: Should this be deleted?
    field :label, :string, null: false

    has_many :contacts_phone_numbers, ContactDemo.ContactPhoneNumber
    has_many :contacts, through: [:contacts_phone_numbers, :contact]

    timestamps
  end

  @required_fields ~w(number label)
  @optional_fields ~w(kind)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:number, :label])
    # TODO: Validate phone number (across countries?)
    |> validate_length(:number, min: 1, max: 255)
    # |> validate_length(:kind, min: 1, max: 255)
    |> validate_length(:label, min: 1, max: 255)
    |> validate_inclusion(:label, labels)
    |> prepare_version(opts)
  end

  def labels, do: ["Primary Phone", "Secondary Phone", "Home Phone",
                   "Work Phone", "Mobile Phone", "Other Phone"]

  def all_labels do
    (from p in PhoneNumber, group_by: p.label, select: p.label)
    |> Repo.all
  end

  def find_by_label(phone_numbers, label) do
    Enum.find phone_numbers, %{}, &(&1.label == label)
  end

  def label_abbr(%PhoneNumber{label: label}) do
    label
    |> String.first
    |> String.upcase
  end

  def format_phone_numbers_abbriviated(numbers) do
    Enum.reduce numbers, "", fn(pn, acc) ->
      prefix = if acc == "", do: "", else: ", "
      acc <> prefix <> "(#{PhoneNumber.label_abbr(pn)}) #{pn.number}"
    end
  end
end
