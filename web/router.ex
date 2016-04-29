defmodule Nested.Router do
  use Nested.Web, :router
  use ExAdmin.Router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # your app's routes

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
  end

  scope "/", Nested do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/categories", CategoryController
    resources "/users", UserController
    resources "/contacts", ContactController
    resources "/groups", GroupController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Nested do
  #   pipe_through :api
  # end
end
