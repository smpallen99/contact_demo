defmodule ContactDemo.Factory do
  use ExMachina.Ecto, repo: ContactDemo.Repo

  alias ContactDemo.{Category, Contact, ContactGroup, ContactPhoneNumber, Group, PhoneNumber, Role, User, UserRole}
  alias FakerElixir.{App, Color, Internet, Lorem, Name, Number, Phone}
  alias Timex.Date

  def user_factory do
    %User{
      name: Name.name,
      username: Internet.user_name,
      email: Internet.email,
      encrypted_password: "changeme",
      password: "changeme",
      password_confirmation: "changeme"
    }
  end

  def category_factory do
    %Category{
      name: App.name,
      position: 42
    }
  end

  def contact_group_factory do
    %ContactGroup{
      contact: build(:contact),
      group: build(:group)
    }
  end

  def contact_factory do
    %Contact{
      first_name: Name.first_name,
      last_name: Name.last_name,
      email: Internet.email,
      category: build(:category)
    }
  end

  def group_factory do
    %Group{
      name: Color.name
    }
  end

  def role_factory do
    %Role{
      name: Name.name
    }
  end

  def phone_number_factory do
    %PhoneNumber{
      number: Phone.cell,
      label: Enum.random(PhoneNumber.labels)
    }
  end

  def contact_phone_number_factory do
    %ContactPhoneNumber{
      contact: build(:contact),
      phone_number: build(:phone_number)
    }
  end

  def user_role_factory do
    %UserRole{
      user: build(:user),
      role: build(:role)
    }
  end
end
