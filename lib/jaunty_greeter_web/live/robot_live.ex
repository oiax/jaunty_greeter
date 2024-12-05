defmodule JauntyGreeterWeb.RobotLive do
  use JauntyGreeterWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:counter, 0)
      |> assign(:name, "world")

    {:ok, socket}
  end

  def handle_event("increment_counter", %{"delta" => delta}, socket) do
    delta =
      case Integer.parse(delta) do
        {n, _} -> n
        :error -> 0
      end

    socket = update(socket, :counter, &(&1 + delta))
    {:noreply, socket}
  end

  def handle_event("change_name", %{"name" => name}, socket) do
    socket = assign(socket, :name, name)
    {:noreply, socket}
  end
end
