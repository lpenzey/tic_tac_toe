defmodule Validity_Test do
  use ExUnit.Case
  doctest Validity

  describe "when input is valid" do
    setup do
      %{
        valid_move: "1",
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

    test "can convert move to internal state", context do
      assert Validity.user_move_to_internal_state(context[:valid_move]) == {0, 0}
    end

    test "confirms input is a number", context do
      assert Validity.number?(context[:valid_move])
    end

    test "identifies input as a space that exists on the board", context do
      assert Validity.user_move_to_internal_state(context[:valid_move])
    end

    test "confirms space is open", context do
      assert Validity.open?(context[:valid_move], context[:initial_state])
    end
  end

  describe "when input is not valid" do
    setup do
      %{
        intermediary_state: %State{
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

    test "returns argument error if input is nan" do
      assert Validity.user_move_to_internal_state("a") == {:error, "argument error"}
    end

    test "identifies input as not matching an existing space" do
      assert Validity.user_move_to_internal_state("10") == :nonexistant_space
    end

    test "identifies input as not a number" do
      assert Validity.number?("a") == false
    end

    test "identifies space that has been taken by \"X\"", context do
      assert Validity.open?("1", context[:intermediary_state]) == false
    end

    test "identifies space that has been taken by \"O\"", context do
      assert Validity.open?("2", context[:intermediary_state]) == false
    end
  end
end
