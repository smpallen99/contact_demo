defmodule ContactDemo.PhoneNumberTest do
  use ContactDemo.ModelCase

  alias ContactDemo.PhoneNumber

  describe "validations" do
    test "changeset with valid attributes" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, params_with_assocs(:phone_number))
      assert changeset.valid?
    end

    test "number: if changeset is nil" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: nil}))
      refute changeset.valid?
      assert {:number, {"can't be blank", []}} in changeset.errors
    end

    test "number: if changeset is zero-length" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: ""}))
      refute changeset.valid?
      assert {:number, {"can't be blank", []}} in changeset.errors
    end

    test "number: if changeset is blank" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: " "}))
      refute changeset.valid?
      assert {:number, {"can't be blank", []}} in changeset.errors
    end

    test "number: raises a validation error if the length of the text is > 255 characters" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{number: Lorem.words(256)}))
      refute changeset.valid?
      assert {:number, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
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

    test "label: raises a validation error if the length of the text is > 255 characters" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{label: Lorem.words(256)}))
      refute changeset.valid?
      assert {:label, {"should be at most %{count} character(s)", [count: 255]}} in changeset.errors
    end

    test "label: has to be only one among a specific set of values" do
      changeset = PhoneNumber.changeset(%PhoneNumber{}, Map.merge(params_with_assocs(:phone_number), %{label: Lorem.word}))
      refute changeset.valid?
      assert {:label, {"is invalid", []}} in changeset.errors
    end
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
