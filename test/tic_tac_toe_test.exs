defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe "when game is a tie" do
    setup do
      %{
        initial_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
            {1, 0} => "O",
            {1, 1} => "X",
            {1, 2} => "O",
            {2, 0} => "O",
            {2, 1} => "X",
            {2, 2} => "O"
          },
          player: "X"
        }
      }
    end
  end
end
