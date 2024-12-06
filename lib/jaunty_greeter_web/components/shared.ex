defmodule JauntyGreeterWeb.Shared do
  use JauntyGreeterWeb, :html

  embed_templates "shared/*"

  slot :inner_block, required: true
  attr :label, :string, default: "Label"
  attr :active, :boolean, default: false

  def tab_and_panel(assigns)
end
