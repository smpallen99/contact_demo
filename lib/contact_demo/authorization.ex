alias ContactDemo.Authentication, as: Auth
alias ContactDemo.Authorization, as: Authz
alias ContactDemo.{Role, User}

# defimpl ExAdmin.Authorization, for: ContactDemo.User do
#   def authorize_query(resource, conn, query, _action, _id),
#     do: Authz.authorize_user_query(resource, conn, query)
#   def authorize_action(_resource, conn, action),
#     do: Authz.authorize_actions(action, Auth.current_user(conn),
#           except: [:create, :new, :destroy, :delete])
# end

defimpl ExAdmin.Authorization, for: ContactDemo.Category do
  def authorize_query(_resource, _conn, query, _action, _id), do: query
  def authorize_action(_resource, conn, action) do
    user = Auth.current_user(conn)
    excepted = case User.has_role?(user, Role.admin) do
      true -> %{except: []}
      _ -> %{except: [:destroy, :delete]}
    end
    Authz.authorize_actions(action, user, excepted)
  end
end

# defimpl ExAdmin.Authorization, for: ContactDemo.Option do
#   def authorize_query(_resource, _conn, query, _action, _id), do: query
#   def authorize_action(_resource, conn, action),
#     do: Authz.authorize_actions(action, Auth.current_user(conn),
#           only: [:index, :show])
# end
# defimpl ExAdmin.Authorization, for: ContactDemo.Product do
#   def authorize_query(_resource, _conn, query, _action, _id), do: query
#   def authorize_action(_resource, conn, action),
#     do: Authz.authorize_actions(action, Auth.current_user(conn),
#           only: [:index, :show])
# end
# defimpl ExAdmin.Authorization, for: ContactDemo.Version do
#   def authorize_query(_resource, _conn, query, _action, _id), do: query
#   def authorize_action(_resource, conn, action),
#     do: Authz.authorize_actions(action, Auth.current_user(conn),
#           only: [:index, :show])
# end
# defimpl ExAdmin.Authorization, for: ContactDemo.Account do
#   def authorize_query(_resource, _conn, query, _action, _id), do: query
#   def authorize_action(_resource, conn, action),
#     do: Authz.authorize_actions(action, Auth.current_user(conn),
#           except: [:delete, :destroy])
# end

defmodule ContactDemo.Authorization do
  import Ecto.Query

  def authorize_user_query(user, _conn, query) do
    id = user.id
    where(query, [u], u.id == ^id)
  end

  def authorize_actions(action, _, actions) when is_atom(action) do
    only = actions[:only]
    except = actions[:except]
    cond do
      is_list(only) -> action in only
      is_list(except) -> not action in except
      true -> false
    end
  end

  def is_admin?(conn) do
    User.has_role?(Auth.current_user(conn), Role.admin)
  end
end
