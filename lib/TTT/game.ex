defmodule Game do
  def init do
    %State{}
  end

  def play(line, state) do
    line
    |> String.trim("\n")
    |> Input.process_move(state)
    |> Output.print_board(state)
    |> Comp_player.make_move()
    |> Output.print_board(state)
  end
end
