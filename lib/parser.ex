defmodule GenReport.Parser do
  alias GenReport.MonthHelper

  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line), do: line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
    |> List.update_at(3, fn month -> month |> String.to_integer() |> MonthHelper.number_to_month() end)
    |> List.update_at(4, &String.to_integer/1)
end
