defmodule Game do
  def init do
    %State{}
  end

  def play(line, state) do
    line
    |> Input.clean()
    |> Input.place_move(state)
    |> Output.print_board(state)
    |> ComputerPlayer.make_move()
    |> Output.print_board(state)
  end
end
