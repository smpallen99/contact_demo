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

  describe "find_by_label" do
    test "returns an empty struct if input phone numbers is empty" do
      result = PhoneNumber.find_by_label([], "Home Phone")
      assert(result == %{})
    end

    test "returns the matching struct if input phone numbers is not empty" do
      phone_numbers = [build(:phone_number, label: "Work Phone", number: "1"), build(:phone_number, label: "Home Phone", number: "2"), build(:phone_number, label: "Home Phone", number: "3")]
      result = PhoneNumber.find_by_label(phone_numbers, "Home Phone")
      assert(result == %PhoneNumber{label: "Home Phone", number: "2"})
    end

    test "returns the first struct if input phone numbers is not empty and more than 1 match is found" do
      phone_numbers = [build(:phone_number, label: "Work Phone", number: "1"), build(:phone_number, label: "Home Phone", number: "2"), build(:phone_number, label: "Home Phone", number: "3")]
      result = PhoneNumber.find_by_label(phone_numbers, "Work Phone")
      assert(result == %PhoneNumber{label: "Work Phone", number: "1"})
    end
  end

  describe "label_abbr" do
    test "returns the first character in upper case" do
      assert("W" == PhoneNumber.label_abbr(%PhoneNumber{label: "work"}))
    end
  end

  describe "format_phone_numbers_abbreviated" do
    test "returns the formatted phone number if a single one exists" do
      phone_numbers = [build(:phone_number, label: "Work Phone", number: "1")]
      assert("(W) 1" == PhoneNumber.format_phone_numbers_abbreviated(phone_numbers))
    end

    test "returns the formatted phone numbers joined by comma if a more than one exist" do
      phone_numbers = [build(:phone_number, label: "Work Phone", number: "1"), build(:phone_number, label: "Home Phone", number: "2"), build(:phone_number, label: "Home Phone", number: "3")]
      assert("(W) 1, (H) 2, (H) 3" == PhoneNumber.format_phone_numbers_abbreviated(phone_numbers))
    end
  end
end
