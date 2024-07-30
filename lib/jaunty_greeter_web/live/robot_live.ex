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

  def handle_event("change_name", %{"name" => name}, socket) do
    socket = assign(socket, :name, name)
    {:noreply, socket}
  end

  defp button_class(true), do: "btn btn-secondary mx-2"
  defp button_class(false), do: "btn btn-primary mx-2"
end
