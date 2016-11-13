defmodule ContactDemo.Factory do
  use ExMachina.Ecto, repo: ContactDemo.Repo

  alias ContactDemo.{User, Category, ContactGroup, Contact, Group, Role, PhoneNumber, ContactPhoneNumber, UserRole}
  alias FakerElixir, as: Faker

  def user_factory do
    %User{
      name: Faker.Name.name,
      username: Faker.Internet.user_name,
      email: Faker.Internet.email,
      encrypted_password: "changeme",
      password: "changeme",
      password_confirmation: "changeme",
      expire_on: Timex.Date.today
    }
  end

  def category_factory do
    %Category{
      name: Faker.App.name,
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
      first_name: Faker.Name.first_name,
      last_name: Faker.Name.last_name,
      email: Faker.Internet.email,
      category: build(:category)
    }
  end

  def group_factory do
    %Group{
      name: Faker.Color.name
    }
  end

  def role_factory do
    %Role{
      name: sequence(:name, &"Name #{&1}")
    }
  end

  def phone_number_factory do
    %PhoneNumber{
      number: Faker.Phone.cell,
      label: "Mobile Phone"
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
