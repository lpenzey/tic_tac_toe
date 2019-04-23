defmodule InputTest do
  use ExUnit.Case
  doctest Input

  import ExUnit.CaptureIO

  describe "when input is invalid" do
    setup do
      %{
        intermediary_board_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
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

    test "returns NAN error message" do
      assert Input.sanitized_move("a") == {:error, :not_a_number}
    end

    test "retrieve gets user input" do
      Input.retrieve(MockInputOutput)
      assert_received "retrieved user input"
    end

    test "rejects a move for a space that's taken", context do
      assert MockInput.analyze(1, context[:intermediary_board_state]) ==
               {:error, :need_valid_input}
    end

    test "rejects a move for a space that's not on the board", context do
      assert MockInput.analyze(10, context[:intermediary_board_state]) ==
               {:error, :need_valid_input}
    end
  end

  describe "when input is valid" do
    setup do
      %{
        empty_board_state: %State{
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

    test "move returns integer version of input" do
      assert Input.sanitized_move("1") == 1
    end

    test "approves a move for a space that is open", context do
      assert MockInput.analyze(1, context[:empty_board_state]) ==
               {:ok, :move_placed}
    end
  end
end
