defmodule GameTest do
  use ExUnit.Case
  doctest Game

  describe "when game has begun" do
    setup do
      %{
        initial_game_state: %State{
          board: %{
            {0, 0} => 1,
            {0, 1} => 2,
            {0, 2} => 3,
            {1, 0} => 4,
            {1, 1} => 5,
            {1, 2} => 6,
            {2, 0} => 7,
            {2, 1} => 8,
            {2, 2} => 9
          },
          player: "X"
        }
      }
    end

    test "initializes game with player token \"X\"" do
      assert Game.init().player == "X"
    end

    test "initializes game with player token \"O\"" do
      assert Game.init("O").player == "O"
    end
  end

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
