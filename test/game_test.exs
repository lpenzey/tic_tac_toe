defmodule GameTest do
  use ExUnit.Case
  doctest Game

  describe "when game is a tie" do
    setup do
      %{
        tie_game_state: %State{
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

  describe "when game is won" do
    setup do
      %{
        winning_game_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "X",
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
