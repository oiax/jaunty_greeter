defmodule JauntyGreeterWeb.RobotLive do
  use JauntyGreeterWeb, :live_view

  embed_templates "robot_live/*"

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:counter, 0)
      |> assign(:name, "world")
      |> assign(:wizard_step, 0)

    if connected?(socket) do
      Process.send_after(self(), :increment_counter, 1000)
    end

    {:ok, socket}
  end

  def handle_params(%{"step" => step} = _params, _uri, socket)
      when step in ~w(1 2 3 4) do
    {step, ""} = Integer.parse(step)
    socket = assign(socket, :wizard_step, step)
    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    socket = assign(socket, :wizard_step, 0)
    {:noreply, socket}
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

  def handle_info(:increment_counter, socket) do
    Process.send_after(self(), :increment_counter, 1000)
    socket = update(socket, :counter, &(&1 + 1))
    {:noreply, socket}
  end

  defp button_class(true), do: "btn btn-secondary mx-2"
  defp button_class(false), do: "btn btn-primary mx-2"
end
