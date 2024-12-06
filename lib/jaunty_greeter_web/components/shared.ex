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
end
