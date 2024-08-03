defmodule JauntyGreeterWeb.Wizard do
  use JauntyGreeterWeb, :html

  @wizard_total_steps 4

  slot :inner_block, required: true
  attr :step, :integer, required: true

  def step(%{step: 1} = assigns) do
    assigns = assign(assigns, :total_steps, @wizard_total_steps)

    ~H"""
    <h2 class="card-title">Step <%= @step %>/<%= @total_steps %></h2>
    <%= render_slot(@inner_block) %>
    <div class="card-actions justify-between">
      <.cancel_button />
      <.next_button step={@step}></.next_button>
    </div>
    """
  end

  def step(%{step: step, total_steps: total_steps} = assigns)
      when step == total_steps do
    assigns = assign(assigns, :total_steps, @wizard_total_steps)

    ~H"""
    <h2 class="card-title">Step <%= @step %>/<%= @total_steps %></h2>
    <%= render_slot(@inner_block) %>
    <div class="card-actions justify-between">
      <.finish_button />
    </div>
    """
  end

  def step(assigns) do
    assigns = assign(assigns, :total_steps, @wizard_total_steps)

    ~H"""
    <h2 class="card-title">Step <%= @step %>/<%= @total_steps %></h2>
    <%= render_slot(@inner_block) %>
    <div class="card-actions justify-between">
      <.cancel_button />
      <div>
        <.back_button step={@step}></.back_button>
        <.next_button step={@step}></.next_button>
      </div>
    </div>
    """
  end

  defp cancel_button(assigns) do
    ~H"""
    <.link patch={~p"/robot"} class="btn btn-neutral">Cancel</.link>
    """
  end

  defp back_button(assigns) do
    ~H"""
    <.link patch={~p"/robot/wizard/#{@step - 1}"} class="btn btn-secondary">
      Back
    </.link>
    """
  end

  defp next_button(assigns) do
    ~H"""
    <.link patch={~p"/robot/wizard/#{@step + 1}"} class="btn btn-primary">
      Next
    </.link>
    """
  end

  defp finish_button(assigns) do
    ~H"""
    <.link patch={~p"/robot"} class="btn btn-primary">Finish</.link>
    """
  end
end
