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
          player: "X",
          opponent: "O",
          current_player: "X",
          mode: :empty
        }
      }
    end

    test "initializes game with player token \"a\" opponent token \"b\" and current player \"a\"" do
      assert Game.set_options("a", "b", "b", :human_v_human) == %State{
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
               current_player: "b",
               opponent: "b",
               player: "a",
               mode: :human_v_human
             }
    end

    test "returns game mode attribute" do
      assert Game.select_mode("1") == :human_v_human
    end

    test "cycles through moves in human vs. human until a player wins or ties", context do
      Helpers.Stack.setup(["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"])

      mock_io = MockTTT.IO

      assert Regex.match?(
               ~r/game/,
               Game.play(context[:initial_game_state], mock_io, :human_v_human)
             )

      Helpers.Stack.teardown()
    end

    test "cycles through moves in human vs. easy computer until a player wins or ties", context do
      Helpers.Stack.setup(["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"])

      mock_io = MockTTT.IO

      assert Regex.match?(
               ~r/game/,
               Game.play(context[:initial_game_state], mock_io, :human_v_easy_computer)
             )

      Helpers.Stack.teardown()
    end

    test "cycles through moves in human vs. hard computer until a player wins or ties", context do
      Helpers.Stack.setup(["1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"])

      mock_io = MockTTT.IO

      assert Regex.match?(
               ~r/game/,
               Game.play(context[:initial_game_state], mock_io, :human_v_hard_computer)
             )

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
          player: "X",
          opponent: "O",
          current_player: "O"
        }
      }
    end

    test "fills last remaining position", context do
      assert Game.hard_computer_move(context[:one_move_away_state]) == %State{
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
               current_player: "X",
               mode: :empty,
               opponent: "O",
               player: "X"
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
      assert Regex.match?(~r/tie/, Game.over(MockTTT.IO, context[:tie_game_state]))
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
      assert Regex.match?(~r/win/, Game.over(MockTTT.IO, context[:winning_game_state]))
    end

    test "hard computer player returns state when asked to make a move", context do
      assert Game.hard_computer_move(context[:winning_game_state]) == context[:winning_game_state]
    end

    test "easy computer player returns state when asked to make a move", context do
      assert Game.easy_computer_move(context[:winning_game_state]) == context[:winning_game_state]
    end
  end
end
