defmodule JauntyGreeterWeb.HomeController do
  use JauntyGreeterWeb, :controller

  def hello(conn, _params) do
    render(conn, :hello)
  end
end
