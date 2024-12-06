defmodule JauntyGreeterWeb.Shared do
  use JauntyGreeterWeb, :html

  embed_templates "shared/*"

  def simple_card(assigns) do
    ~H"""
    <div class="card bg-base-300 w-96 shadow-xl mx-auto my-4">
      <div class="card-body">
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  slot :inner_block, required: true
  attr :label, :string, default: "Label"
  attr :active, :boolean, default: false

  def tab_and_panel(assigns)
end
