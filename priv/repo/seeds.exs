# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ContactDemo.Repo.insert!(%ContactDemo.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ContactDemo.Contact
alias ContactDemo.Group
alias ContactDemo.Category
alias ContactDemo.User
alias ContactDemo.ContactGroup
alias ContactDemo.Repo
alias ContactDemo.PhoneNumber
alias ContactDemo.ContactPhoneNumber
alias ContactDemo.UserRole
alias ContactDemo.Role

defmodule Faker.Phone do
  def phone_number do
    area_code <> nxx <> ext
  end
  defp area_code do
    last = :rand.uniform(99)
    |> Integer.to_string
    |> String.rjust(2, ?0)
    Integer.to_string(:rand.uniform(8) + 1) <> last
  end
  defp nxx,
    do: :rand.uniform(999) |> Integer.to_string |> String.rjust(3, ?0)
  defp ext,
    do: :rand.uniform(9999) |> Integer.to_string |> String.rjust(4, ?0)

end

Faker.start

[
  ContactPhoneNumber, ContactGroup, UserRole, Contact, Group, User, Category,
  PhoneNumber, Role
] |> Enum.each(&Repo.delete_all/1)

~w(Employees Maintenance Marketing Sales Management)
|> Enum.each(fn(name) ->
  Category.changeset(%Category{}, %{name: name})
  |> Repo.insert!
end)

~w(one two three four)
|> Enum.each(fn(name) ->
  Group.changeset(%Group{}, %{name: name})
  |> Repo.insert!
end)

~w(admin manager user)
|> Enum.each(fn(name) ->
  Role.changeset(%Role{}, %{name: name})
  |> Repo.insert!
end)

groups = Repo.all Group
categories = Repo.all Category
roles = Repo.all Role

for [fname, lname, role] <- [~w(Demo User admin)] do

  user = User.changeset(%User{}, %{
    name: "#{fname} #{lname}",
    email: "#{fname}#{lname}@example.com" |> String.downcase,
    username: "#{fname}#{lname}" |> String.downcase,
    password: "secret",
    password_confirmation: "secret",
    active: true,
    })
  |> Repo.insert!

  r =  Enum.find(roles, &(&1.name == role))
  UserRole.changeset(%UserRole{}, %{
    user_id: user.id,
    role_id: r.id
    })
  |> Repo.insert!

end


for _i <- 1..25 do
  user = User.changeset(%User{}, %{
    name: Faker.Name.En.name,
    email: Faker.Internet.email,
    username: Faker.Internet.user_name,
    password: "secret",
    password_confirmation: "secret",
    active: true,
    })
  |> Repo.insert!

  r = Enum.random roles
  UserRole.changeset(%UserRole{}, %{
    user_id: user.id,
    role_id: r.id
    })
  |> Repo.insert!
end

for _i <- 1..100 do
  category = Enum.random categories
  num_groups = 1..:rand.uniform(4)
  group_list = Enum.reduce(
    num_groups,
    MapSet.new,
      fn(_, acc) ->
        MapSet.put(acc, Enum.random(groups))
      end)

  contact = Contact.changeset(%Contact{}, %{
    first_name: Faker.Name.En.first_name,
    last_name: Faker.Name.En.last_name,
    email: Faker.Internet.email,
    category_id: category.id
    })
  |> Repo.insert!

  # add groups
  Enum.each(group_list, fn(group) ->
    ContactGroup.changeset(%ContactGroup{}, %{
      contact_id: contact.id,
      group_id: group.id
      })
    |> Repo.insert!
  end)

  # add phone_numbers
  labels = Enum.reduce(1..:rand.uniform(2), MapSet.new, fn(_, acc) ->
    MapSet.put acc, Enum.random PhoneNumber.labels
  end)
  for label <- labels do
    pn = PhoneNumber.changeset(%PhoneNumber{}, %{
      number: Faker.Phone.phone_number,
      label: label
    })
    |> Repo.insert!
    ContactPhoneNumber.changeset(%ContactPhoneNumber{}, %{
      contact_id: contact.id,
      phone_number_id: pn.id
    })
    |> Repo.insert!
  end
end


