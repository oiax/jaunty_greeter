defmodule JauntyGreeterWeb.Shared do
  use JauntyGreeterWeb, :html

  embed_templates "shared/*"

  def simple_card(assigns) do
    ~H"""
    <div class="card bg-base-300 w-96 shadow-xl mx-auto my-4">
      <div class="card-body">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  slot :inner_block, required: true
  attr :label, :string, default: "Label"
  attr :active, :boolean, default: false

  def tab_and_panel(assigns)

  # slot :message, required: true
  # attr :total_steps, :integer, required: true
  # attr :step, :integer, :integer, required: true
  # attr :href, :string, :string, required: true

  # def wizard_step(%{step: 1} = assigns) do
  #   ~H"""
  #   <h2 class="card-title">Step <%= @step %>/<%= @total_steps %></h2>
  #   <%= render_slot(:message) %>
  #   <div class="card-actions justify-between">
  #     <.cancel_button></.cancel_button>
  #     <.next_button step={@step}></.next_button>
  #   </div>
  #   """
  # end

  # def wizard_step(%{step: step, total_steps: total_steps} = assigns)
  #     when step == total_steps do
  #   ~H"""
  #   <h2 class="card-title">Step <%= @step %>/<%= @total_steps %></h2>
  #   <%= render_slot(:message) %>
  #   <div class="card-actions justify-between">
  #     <.link patch={@href} class="btn btn-primary">
  #       Finish
  #     </.link>
  #   </div>
  #   """
  # end

  # def wizard_step(assigns) do
  #   ~H"""
  #   <h2 class="card-title">Step <%= @step %>/<%= @total_steps %></h2>
  #   <%= render_slot(:message) %>
  #   <div class="card-actions justify-between">
  #   <.link patch={@href} class="btn btn-neutral">Cancel</.link>
  #     <div>
  #     <.link patch={~p"/robot/wizard/#{@step - 1}"} class="btn btn-secondary">
  #       Back
  #     </.link>
  #   </div>
  #   """
  # end
end
