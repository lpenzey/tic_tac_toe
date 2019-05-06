defmodule ValidationTest do
  use ExUnit.Case
  doctest Validation

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
      assert Validation.sanitized_move("a") == {:error, :not_a_number}
    end

    test "returns nonexistant space error if input is nan" do
      assert Validation.user_move_to_internal_state("a") ==
               {:error, :nonexistant_space}
    end

    test "identifies input as not matching an existing space" do
      assert Validation.user_move_to_internal_state("10") ==
               {:error, :nonexistant_space}
    end

    test "identifies space that has been taken by \"X\"", context do
      assert Validation.open?("1", context[:intermediary_board_state]) == {:error, :space_taken}
    end

    test "identifies space that has been taken by \"O\"", context do
      assert Validation.open?("2", context[:intermediary_board_state]) == {:error, :space_taken}
    end

    test "identifies if input is not an existing space on the board" do
      assert Validation.space_on_board?("10") == {:error, :nonexistant_space}
    end

    test "cycles through invalid mode types until valid entry" do
      Helpers.Stack.setup(["foo\n", "hi!\n", "6\n", "1\n"])

      mock_deps = %{
        validation: MockValidation,
        messages: MockMessages,
        io: MockTTT.IO,
        player: Player
      }

      assert Validation.choose_mode(mock_deps) == "1"

      Helpers.Stack.teardown()
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
      assert Validation.sanitized_move("1") == 1
    end

    test "can convert move to internal state" do
      assert Validation.user_move_to_internal_state(1) == {0, 0}
    end

    test "identifies input as a space that exists on the board" do
      assert Validation.space_on_board?(1) == {:ok, :space_on_board}
    end

    test "confirms space is open", context do
      assert Validation.open?(1, context[:empty_board_state])
    end
  end
end
