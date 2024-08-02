defmodule JauntyGreeterWeb.DroidLive do
  use JauntyGreeterWeb, :live_view

  embed_templates "droid_live/*"

  alias Phoenix.LiveView.JS
end
