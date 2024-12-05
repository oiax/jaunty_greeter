defmodule JauntyGreeterWeb.RobotLive do
  use JauntyGreeterWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:counter, 0)
      |> assign(:name, "world")

    {:ok, socket}
  end

  def handle_event("increment_counter", _params, socket) do
    socket = update(socket, :counter, &(&1 + 1))
    {:noreply, socket}
  end
end
