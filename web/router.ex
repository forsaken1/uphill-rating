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
    get "/results", PageController, :results
    get "/rating", PageController, :rating
    get "/rating_teams", PageController, :rating_teams
    get "/about", PageController, :about
    resources "/bicyclists", BicyclistsController, only: [:show]
    resources "/teams", TeamsController, only: [:show]
  end

  # setup the ExAdmin routes on /admin
  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
  end

  scope "/admin", UphillRating do
    pipe_through :browser
    post "/bicyclist_races/import", AdminController, :import
  end

  # Other scopes may use custom stacks.
  # scope "/api", UphillRating do
  #   pipe_through :api
  # end
end
