defmodule JauntyGreeterWeb.Shared do
  use JauntyGreeterWeb, :html

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
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
