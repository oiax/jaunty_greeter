defmodule JauntyGreeterWeb.RobotLive do
  use JauntyGreeterWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:counter, 0)
      |> assign(:name, "world")

    Process.send_after(self(), :increment_counter, 1000)

    {:ok, socket}
  end

  def handle_info(:increment_counter, socket) do
    socket = assign(socket, :counter, socket.assigns.counter + 1)

    Process.send_after(self(), :increment_counter, 1000)

    {:noreply, socket}
  end
end
