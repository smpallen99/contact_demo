defmodule ContactDemo.ExAdmin.Category do
  use ExAdmin.Register
  alias ContactDemo.{Category, Repo, AdminView}
  alias Phoenix.{Controller, HTML.Tag, View}

  register_resource ContactDemo.Category do
    index do
      selectable_column

      column :name, fn(c) ->
        Tag.content_tag(:span, c.name, "data-id": c.id, class: "category")
        |> elem(1)
        |> text
      end
      actions
    end

    form category do
      inputs do
        input category, :name
      end
    end

    show category do
      attributes_table do
        row :name
      end

      panel "Contacts" do
        table_for(category.contacts) do
          column :id, link: true
          column :first_name
          column :last_name
          column :email
        end
      end
    end

    query do
      %{
        all: [preload: [:contacts]],
        index: [query: Category |> order_by([c], asc: c.position)]
      }
    end
    collection_action :sort, &__MODULE__.sort_action/2

    sidebar "ExAdmin Demo", only: [:index, :show] do
      View.render AdminView, "sidebar_links.html", [model: "category"]
    end
  end

  def sort_action(conn, params) do
    ids = for id <- params[:ids], do: String.to_integer(id)
    ids |> Enum.each(fn(id) ->
      c = Repo.get Category, id
      new_index = Enum.find_index(ids, &(&1 == c.id)) + 1
      unless c.position == new_index do
        Repo.update struct(c, position: new_index)
      end
    end)
    Controller.text conn, ""
  end
end
