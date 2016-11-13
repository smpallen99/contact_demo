defmodule ContactDemo.PhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.PhoneNumber

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, params_with_assocs(:phone_number))
      assert changeset.valid?
    end

    test "number: if changeset has nil number" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: nil}))
      refute changeset.valid?
      assert {:number, {"can't be blank", []}} in changeset.errors
    end

    test "number: if changeset has zero-length number" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: ""}))
      refute changeset.valid?
      assert {:number, {"can't be blank", []}} in changeset.errors
    end

    test "number: if changeset has blank number" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: " "}))
      refute changeset.valid?
      assert {:number, {"can't be blank", []}} in changeset.errors
    end

    test "label: if changeset has nil label" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{label: nil}))
      refute changeset.valid?
      assert {:label, {"can't be blank", []}} in changeset.errors
    end

    test "label: if changeset has zero-length label" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{label: ""}))
      refute changeset.valid?
      assert {:label, {"can't be blank", []}} in changeset.errors
    end

    test "label: if changeset has blank label" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{label: " "}))
      refute changeset.valid?
      assert {:label, {"can't be blank", []}} in changeset.errors
    end

    @tag :skip
    test "label: has to be only one among a specific set of values"
  end

  describe "relationships" do
    @tag :skip
    test "has many contacts_phone_numbers"

    @tag :skip
    test "has many contacts through contacts_phone_numbers"
  end

  describe "all_labels" do
    @tag :skip
    test "to be implemented"
  end

  describe "find_by_label" do
    @tag :skip
    test "to be implemented"
  end

  describe "label_abbr" do
    @tag :skip
    test "to be implemented"
  end

  describe "format_phone_numbers_abbriviated" do
    @tag :skip
    test "to be implemented"
  end
end
