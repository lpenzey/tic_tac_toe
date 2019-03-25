defmodule Game do
  def init do
    %State{}
  end

  def play(line, state) do
    line
    |> String.trim("\n")
    |> Input.process_move(state)
    |> Output.print_board(:console)
  end
end
