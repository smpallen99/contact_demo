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
      plug Coherence.Authentication.Session, login: true
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :public do
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
  # your app's routes

  # Add this block
  scope "/" do
    pipe_through :public
    coherence_routes :public
  end

  scope "/" do
    pipe_through :browser
    coherence_routes :private
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
    post "/:resource/sort", AdminController, :sort
  end

  scope "/", ContactDemo do
    pipe_through :browser # Use the default browser stack

    resources "/categories", CategoryController
    resources "/users", UserController
    resources "/contacts", ContactController
    resources "/groups", GroupController
    resources "/roles", RoleController
  end

  scope "/", ContactDemo do
    pipe_through :public
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ContactDemo do
  #   pipe_through :api
  # end
end
