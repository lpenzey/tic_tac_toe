defmodule GameTest do
  use ExUnit.Case
  doctest Game

  import ExUnit.CaptureIO

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

    test "end of game message is called with a tie", context do
      tie_game = capture_io(fn -> Game.play(true, context[:initial_state]) end)

      assert String.contains?(tie_game, "tie")
    end
  end

  describe "when game is won" do
    setup do
      %{
        initial_state: %State{
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

    test "end of game message is called with a win", context do
      tie_game = capture_io(fn -> Game.play(true, context[:initial_state]) end)

      assert String.contains?(tie_game, "winning")
    end
  end
end
