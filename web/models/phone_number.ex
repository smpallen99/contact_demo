defmodule ContactDemo.PhoneNumber do
  use ContactDemo.Web, :model
  use Whatwasit

  alias __MODULE__
  alias ContactDemo.Repo

  schema "phone_numbers" do
    field :number, :string, null: false
    field :label, :string, null: false

    has_many :contacts_phone_numbers, ContactDemo.ContactPhoneNumber
    has_many :contacts, through: [:contacts_phone_numbers, :contact]

    timestamps
  end

  @required_fields ~w(number label)
  @optional_fields ~w()

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:number, :label])
    # TODO: Validate phone number (across countries?)
    |> validate_length(:number, min: 1, max: 255)
    |> validate_length(:label, min: 1, max: 255)
    |> validate_inclusion(:label, labels)
    |> prepare_version(opts)
  end

  @labels ["Primary Phone", "Secondary Phone", "Mobile Phone", "Home Phone", "Work Phone", "Other Phone"]
  def labels, do: @labels

  def find_by_label(phone_numbers, label) do
    Enum.find phone_numbers, %{}, &(&1.label == label)
  end

  def label_abbr(%__MODULE__{label: label}) do
    label |> String.first |> String.upcase
  end

  def format_phone_numbers_abbreviated(numbers) do
    Enum.reduce numbers, "", fn(pn, acc) ->
      prefix = if acc == "", do: "", else: ", "
      acc <> prefix <> "(#{__MODULE__.label_abbr(pn)}) #{pn.number}"
    end
  end
end
