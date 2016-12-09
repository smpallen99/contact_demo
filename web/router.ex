defmodule ContactDemo.Router do
  use ContactDemo.Web, :router
  use ExAdmin.Router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # TODO: Not sure if this is the correct way to bypass authentication during testing
    unless Mix.env == :test do
      plug Coherence.Authentication.Session
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # TODO: Not sure if this is the correct way to bypass authentication during testing
    unless Mix.env == :test do
      plug Coherence.Authentication.Session, login: true
    end
  end
  # your app's routes

  # TODO: Not sure whether this block can be removed or not
  scope "/" do
    pipe_through :browser
    coherence_routes :public
  end

  # TODO: Not sure whether this block can be removed or not
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/admin", ExAdmin do
    pipe_through :protected
    admin_routes
    post "/:resource/sort", AdminController, :sort
  end

  scope "/", ContactDemo do
    pipe_through :protected # Use the default browser stack

    resources "/categories", CategoryController
    resources "/users", UserController
    resources "/contacts", ContactController
    resources "/groups", GroupController
    resources "/roles", RoleController
  end

  scope "/", ContactDemo do
    pipe_through :browser
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ContactDemo do
  #   pipe_through :api
  # end
end
