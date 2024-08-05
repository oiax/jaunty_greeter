defmodule JauntyGreeterWeb.CyborgLive do
  use JauntyGreeterWeb, :live_view
  alias JauntyGreeterWeb.Shared

  embed_templates "cyborg_live/*"

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:raw_json_data, nil)
      |> assign(:daily_records, nil)
      |> assign(:error, nil)
      |> assign(:chart_svg, nil)

    if connected?(socket), do: send(self(), :get_daily_records)

    {:ok, socket}
  end

  @open_metro_base_uri "https://api.open-meteo.com/v1/forecast"
  @tokyo_latitude 35.6894
  @tokyo_longitude 139.6917

  def handle_info(:get_daily_records, socket) do
    uri =
      @open_metro_base_uri
      |> URI.parse()
      |> URI.append_query("latitude=#{@tokyo_latitude}")
      |> URI.append_query("longitude=#{@tokyo_longitude}")
      |> URI.append_query("daily=temperature_2m_max,temperature_2m_min")
      |> URI.append_query("timezone=Asia%2FTokyo")

    case Req.get(uri) do
      {:ok, resp} ->
        if is_map(resp.body) do
          socket =
            socket
            |> assign(:raw_json_data, resp.body)
            |> assign(:daily_records, construct_daily_records(resp.body))

          send(self(), :draw_chart)

          {:noreply, socket}
        else
          {:noreply, assign(socket, :error, resp.body)}
        end

      {:error, ex} ->
        {:noreply, assign(socket, :error, ex)}
    end
  end

  def handle_info(:draw_chart, socket) do
    max_values =
      socket.assigns.daily_records
      |> Enum.map(fn r ->
        %{
          max_or_min: "Max. temperature",
          date: r.date,
          temperature: r.max_value
        }
      end)

    min_values =
      socket.assigns.daily_records
      |> Enum.map(fn r ->
        %{
          max_or_min: "Min. temperature",
          date: r.date,
          temperature: r.min_value
        }
      end)

    chart_svg =
      VegaLite.new(width: 200, height: 200)
      |> VegaLite.data_from_values(max_values ++ min_values)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "date", type: :temporal, title: "Date")
      |> VegaLite.encode_field(:y, "temperature",
        type: :quantitative,
        scale: %{domain: [10, 40]},
        title: "Temperature"
      )
      |> VegaLite.encode_field(:color, "max_or_min", type: :nominal, title: "")
      |> VegaLite.config(
        legend: %{orient: "bottom", layout: %{bottom: %{anchor: "middle"}}}
      )
      |> VegaLite.Export.to_svg()
      |> Phoenix.HTML.raw()

    {:noreply, assign(socket, :chart_svg, chart_svg)}
  end

  defp construct_daily_records(%{"daily" => daily_data} = _raw_json_data) do
    dates = Map.get(daily_data, "time")
    max_values = Map.get(daily_data, "temperature_2m_max")
    min_values = Map.get(daily_data, "temperature_2m_min")

    [dates, max_values, min_values]
    |> Enum.zip()
    |> Enum.map(fn {date, max_value, min_value} ->
      %TemperatureData.DailyRecord{
        date: date,
        max_value: max_value,
        min_value: min_value
      }
    end)
  end

  defp construct_daily_records(_raw_json_data), do: nil
end
