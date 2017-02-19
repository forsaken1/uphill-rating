defmodule TimeHelper do
  def time_with_mc(t) do
    if t == nil do
      nil
    else
      "#{t |> hour}:#{t |> min}:#{t |> sec}.#{t |> usec}"
    end
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

  def diff(first, second) do
    usec = first.usec - second.usec

    sec = if usec < 0 do
      usec = 1000000 + usec
      first.sec - second.sec - 1
    else
      first.sec - second.sec
    end

    min = if sec < 0 do
      sec = 60 + sec
      first.min - second.min - 1
    else
      first.min - second.min
    end

    hour = if min < 0 do
      min = 60 + min
      first.hour - second.hour - 1
    else
      first.hour - second.hour
    end

    Ecto.Time.cast {hour, min, sec, usec}
  end
end
