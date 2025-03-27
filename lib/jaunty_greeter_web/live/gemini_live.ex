defmodule JauntyGreeterWeb.GeminiLive do
  use JauntyGreeterWeb, :live_view
  alias JauntyGreeterWeb.CoreComponents
  # alias JauntyGreeterWeb.Shared

  embed_templates "gemini_live/*"

  def mount(_params, _session, socket) do
    socket = assign(socket, :changeset, Prompt.changeset())
    {:ok, socket}
  end
end
