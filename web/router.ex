defmodule UphillRating.Router do
  use UphillRating.Web, :router
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

  scope "/", UphillRating do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/rating", PageController, :rating
    get "/rating_teams", PageController, :rating_teams
  end

  # setup the ExAdmin routes on /admin
  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
  end

  # Other scopes may use custom stacks.
  # scope "/api", UphillRating do
  #   pipe_through :api
  # end
end
