defmodule GenReport do
  alias GenReport.Parser
  alias GenReport.MonthHelper

  def build(filename) when is_bitstring(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(generate_initial_value(), &map_values(&1, &2))
  end

  def build, do: {:error, "Insira o nome de um arquivo"}

  defp generate_initial_value do
    %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{},
    }
  end

  defp map_values([name, hours, _day, month, year], %{
    "all_hours" => all_hours,
    "hours_per_month" => hours_per_month,
    "hours_per_year" => hours_per_year,
  } = report) do
    all_hours = if Map.has_key?(all_hours, name) do
      Map.put(all_hours, name, hours + all_hours[name])
    else
      Map.put(all_hours, name, hours)
    end

    hours_per_month = if Map.has_key?(hours_per_month, name) do
      client_hours_per_month = hours_per_month[name]
      client_hours_per_month = Map.put(client_hours_per_month, month, hours + hours_per_month[name][month])
      Map.put(hours_per_month, name, client_hours_per_month)
    else
      generated_hours_month = Map.put(hours_per_month, name, MonthHelper.generate_hours_per_month())
      client_hours_per_month = generated_hours_month[name]
      client_hours_per_month = Map.put(client_hours_per_month, month, hours)
      Map.put(hours_per_month, name, client_hours_per_month)
    end

    hours_per_year = if Map.has_key?(hours_per_year, name) do
      client_hours_per_year = hours_per_year[name]

      client_hours_per_year = if Map.has_key?(client_hours_per_year, year) do
        client_hours_per_year
      else
        Map.put(client_hours_per_year, year, 0)
      end

      client_hours_per_year = Map.put(client_hours_per_year, year, hours + client_hours_per_year[year])
      Map.put(hours_per_year, name, client_hours_per_year)
    else
      client_hours_per_year = Map.put(%{}, year, hours)
      Map.put(hours_per_year, name, client_hours_per_year)
    end

    %{report |
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year,
    }
  end
end
