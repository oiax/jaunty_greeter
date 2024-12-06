defmodule JauntyGreeterWeb.Shared do
  use JauntyGreeterWeb, :html

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

  def tab_and_panel(assigns) do
    ~H"""
    <input
      type="radio"
      name="selected_tab"
      role="tab"
      class="tab [--tab-border-color:black] focus:ring-transparent"
      aria-label={@label}
      checked={@active}
    />
    <div role="tabpanel" class="tab-content p-10">
      {render_slot(@inner_block)}
    </div>
    """
  end
end
