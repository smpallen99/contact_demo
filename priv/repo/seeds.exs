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

alias ContactDemo.{Category, Contact, ContactGroup, ContactPhoneNumber, Group, PhoneNumber, Repo, Role, User, UserRole}
alias FakerElixir.{Internet, Name, Phone}
alias Coherence.ControllerHelpers

[
  ContactPhoneNumber, ContactGroup, Contact, Group, Category,
  PhoneNumber
] |> Enum.each(&Repo.delete_all/1)

~w(Employees Maintenance Marketing Sales Management)
|> Enum.with_index |> Enum.each(fn({name, index}) ->
  Category.changeset(%Category{}, %{name: name, position: index})
  |> Repo.insert!
end)

~w(one two three four)
|> Enum.each(fn(name) ->
  Group.changeset(%Group{}, %{name: name})
  |> Repo.insert!
end)

groups = Group.all
categories = Category.all
roles = Role.all

for _i <- 1..25 do
  user = User.changeset(%User{}, %{
    name: Name.name,
    email: Internet.email,
    username: Internet.user_name,
    password: "secret",
    password_confirmation: "secret",
    active: true,
  })
  |> Repo.insert!

  if Enum.random([true, false]) == true, do: ControllerHelpers.confirm! user

  r = Enum.random(roles)
  UserRole.changeset(%UserRole{}, %{
    user_id: user.id,
    role_id: r.id
  })
  |> Repo.insert!
end

for _i <- 1..100 do
  category = Enum.random(categories)
  num_groups = 1..:rand.uniform(4)
  group_list = Enum.reduce(
    num_groups,
    MapSet.new,
      fn(_, acc) ->
        MapSet.put(acc, Enum.random(groups))
      end)

  contact = Contact.changeset(%Contact{}, %{
    first_name: Name.first_name,
    last_name: Name.last_name,
    email: Internet.email,
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
    MapSet.put acc, Enum.random(PhoneNumber.labels)
  end)
  for label <- labels do
    pn = PhoneNumber.changeset(%PhoneNumber{}, %{
      number: Phone.cell,
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
