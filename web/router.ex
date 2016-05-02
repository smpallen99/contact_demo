defmodule Nested.Router do
  use Nested.Web, :router
  use ExAdmin.Router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PlugAuth.Authentication.Database, db_model: Nested.User, login: &Nested.SessionController.login_callback/1
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :public do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
  end

  # your app's routes

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
    post "/:resource/sort", AdminController, :sort
  end

  scope "/", Nested do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/categories", CategoryController
    resources "/users", UserController
    resources "/contacts", ContactController
    resources "/groups", GroupController
    resources "/roles", RoleController
  end

  scope "/", Nested do
    pipe_through :public

    get "/sign_in", SessionController, :new
    post "/sign_in", SessionController, :create
    patch "/sign_out", SessionController, :destroy
    delete "/sign_out", SessionController, :destroy
  end

  # Other scopes may use custom stacks.
  # scope "/api", Nested do
  #   pipe_through :api
  # end
end
