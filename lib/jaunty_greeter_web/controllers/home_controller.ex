defmodule JauntyGreeterWeb.HomeController do
  use JauntyGreeterWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def hello(conn, _params) do
    render(conn, :hello)
  end
end
