defmodule JauntyGreeterWeb.Router do
  use JauntyGreeterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JauntyGreeterWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JauntyGreeterWeb do
    pipe_through :browser

    get "/", HomeController, :hello
  end
end
