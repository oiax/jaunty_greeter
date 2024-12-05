defmodule JauntyGreeterWeb.RobotLive do
  use JauntyGreeterWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:counter, 0)
      |> assign(:name, "world")

    {:ok, socket}
  end
end
