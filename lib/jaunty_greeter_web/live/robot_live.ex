defmodule JauntyGreeterWeb.RobotLive do
  use JauntyGreeterWeb, :live_view

  embed_templates "robot_live/*"

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:counter, 0)
      |> assign(:name, "world")
      |> assign(:wizard_step, 0)

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

  def handle_event("set_wizard_step", %{"step" => step}, socket)
      when step in ~w(0 1 2 3 4) do
    {step, ""} = Integer.parse(step)
    socket = assign(socket, :wizard_step, step)
    {:noreply, socket}
  end

  defp button_class(true), do: "btn btn-secondary mx-2"
  defp button_class(false), do: "btn btn-primary mx-2"

  defp wizard(%{step: 0} = assigns), do: wizard_step0(assigns)
  defp wizard(%{step: 1} = assigns), do: wizard_step1(assigns)
  defp wizard(%{step: 2} = assigns), do: wizard_step2(assigns)
  defp wizard(%{step: 3} = assigns), do: wizard_step3(assigns)
  defp wizard(%{step: 4} = assigns), do: wizard_step4(assigns)
end
