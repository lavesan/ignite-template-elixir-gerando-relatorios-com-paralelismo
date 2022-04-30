defmodule GenReport.MonthHelper do
  def generate_hours_per_month do
    %{
      "janeiro" => 0,
      "fevereiro" => 0,
      "março" => 0,
      "abril" => 0,
      "maio" => 0,
      "junho" => 0,
      "julho" => 0,
      "agosto" => 0,
      "setembro" => 0,
      "outubro" => 0,
      "novembro" => 0,
      "dezembro" => 0,
    }
  end

  def number_to_month(number) when number >= 1 and number <= 12 do
    case number do
      1 -> "janeiro"
      2 -> "fevereiro"
      3 -> "março"
      4 -> "abril"
      5 -> "maio"
      6 -> "junho"
      7 -> "julho"
      8 -> "agosto"
      9 -> "setembro"
      10 -> "outubro"
      11 -> "novembro"
      12 -> "dezembro"
    end
  end
end
