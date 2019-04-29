defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  import ExUnit.CaptureIO

  describe "before a game has begun" do
    setup do
      %{
        initial_state: %State{
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

    test "cycles through moves until the game ends" do
      Helpers.Stack.setup(["x\n", "1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"])

      end_game_status = capture_io(fn -> TicTacToe.main() end)

      assert String.contains?(end_game_status, "game")

      Helpers.Stack.teardown()
    end
  end
end
