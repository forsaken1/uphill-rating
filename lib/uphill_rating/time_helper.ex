defmodule TimeHelper do
  def time_with_mc(t) do
    "#{t |> hour}:#{t |> min}:#{t |> sec}.#{t |> usec}"
  end

  defp hour(t) do
    if t.hour < 10 do
      "0#{t.hour}"
    else
      t.hour
    end
  end

  defp min(t) do
    if t.min < 10 do
      "0#{t.min}"
    else
      t.min
    end
  end

  defp sec(t) do
    if t.sec < 10 do
      "0#{t.sec}"
    else
      t.sec
    end
  end

  defp usec(t) do
    round t.usec / 100000
  end
end
