# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Nested.Repo.insert!(%Nested.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Nested.Contact
alias Nested.Group
alias Nested.Category
alias Nested.User
alias Nested.ContactGroup
alias Nested.Repo

Faker.start

[ContactGroup, Contact, Group, User, Category]
|> Enum.each(&Repo.delete_all/1)

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

groups = Repo.all Group
categories = Repo.all Category

for _i <- 1..100 do
  category = Enum.random categories
  group = Enum.random groups
  contact = Contact.changeset(%Contact{}, %{
    first_name: Faker.Name.En.first_name,
    last_name: Faker.Name.En.last_name,
    email: Faker.Internet.En.free_email_service,
    category_id: category.id
    })
  |> Repo.insert!

  ContactGroup.changeset(%ContactGroup{}, %{
    contact_id: contact.id,
    group_id: group.id
    })
  |> Repo.insert!
end


