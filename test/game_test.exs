defmodule GameTest do
  use ExUnit.Case
  doctest Game

  import ExUnit.CaptureIO

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

    test "returns game mode attribute" do
      assert Game.select_mode("1") == :human_v_human
    end

    test "cycles through moves in human vs. human until a player wins or ties", context do
      Helpers.Stack.setup(["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"])

      mock_deps = %{
        validation: MockValidation,
        messages: MockMessages,
        io: MockTTT.IO,
        player: Player
      }

      game_status =
        capture_io(fn -> Game.play(context[:initial_game_state], mock_deps, :human_v_human) end)

      assert String.contains?(game_status, "game")

      Helpers.Stack.teardown()
    end

    test "cycles through moves in human vs. computer until a player wins or ties", context do
      Helpers.Stack.setup(["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"])

      mock_deps = %{
        validation: MockValidation,
        messages: MockMessages,
        io: MockTTT.IO,
        player: Player
      }

      game_status =
        capture_io(fn -> Game.play(context[:initial_game_state], mock_deps, :human_v_computer) end)

      assert String.contains?(game_status, "game")

      Helpers.Stack.teardown()
    end
  end

  describe "when game is one move from ending" do
    setup do
      %{
        one_move_away_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
            {1, 0} => "O",
            {1, 1} => "X",
            {1, 2} => "O",
            {2, 0} => "O",
            {2, 1} => "X",
            {2, 2} => 9
          },
          player: "X"
        }
      }
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

    test "outputs tie message", context do
      end_of_game = capture_io(fn -> Game.over(context[:tie_game_state]) end)

      assert String.contains?(end_of_game, "tie")
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

    test "outputs win message", context do
      end_of_game = capture_io(fn -> Game.over(context[:winning_game_state]) end)

      assert String.contains?(end_of_game, "win")
    end
  end
end
