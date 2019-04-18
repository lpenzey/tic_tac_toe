defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  describe "when board is empty" do
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

    test "gets initial game values", context do
      assert Board.gen_values(context[:empty_board_state]) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    test "builds an empty 3x3 board", context do
      assert Board.build(context[:empty_board_state]) ==
               "┌───┬───┬───┐\n│ 1 │ 2 │ 3 │\n├───┼───┼───┤\n│ 4 │ 5 │ 6 │\n├───┼───┼───┤\n│ 7 │ 8 │ 9 │\n└───┴───┴───┘"
    end

    test "swaps board keys and values", context do
      assert Board.invert(context[:empty_board_state]) == %{
               1 => {0, 0},
               2 => {0, 1},
               3 => {0, 2},
               4 => {1, 0},
               5 => {1, 1},
               6 => {1, 2},
               7 => {2, 0},
               8 => {2, 1},
               9 => {2, 2}
             }
    end

    test "can convert move to internal state" do
      assert Board.user_move_to_internal_state(1) == {0, 0}
    end

    test "returns nonexistant space error if input is nan" do
      assert Board.user_move_to_internal_state("a") == {:error, :nonexistant_space}
    end

    test "identifies input as not matching an existing space" do
      assert Board.user_move_to_internal_state("10") == {:error, :nonexistant_space}
    end
  end

  describe "when board has one move" do
    setup do
      %{
        one_move_board_state: %State{
          board: %{
            {0, 0} => "X",
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

    test "gets updated board values", context do
      assert Board.gen_values(context[:one_move_board_state]) == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    end

    test "builds a 3x3 board with a user move", context do
      assert Board.build(context[:one_move_board_state]) ==
               "┌───┬───┬───┐\n│ X │ 2 │ 3 │\n├───┼───┼───┤\n│ 4 │ 5 │ 6 │\n├───┼───┼───┤\n│ 7 │ 8 │ 9 │\n└───┴───┴───┘"
    end
  end

  describe "when board is full" do
    setup do
      %{
        full_board_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
            {1, 0} => "O",
            {1, 1} => "X",
            {1, 2} => "O",
            {2, 0} => "X",
            {2, 1} => "O",
            {2, 2} => "X"
          },
          player: "X"
        }
      }
    end

    test "gets updated board values", context do
      assert Board.gen_values(context[:full_board_state]) == [
               "X",
               "O",
               "X",
               "O",
               "X",
               "O",
               "X",
               "O",
               "X"
             ]
    end

    test "builds a 3x3 board with all moves completed", context do
      assert Board.build(context[:full_board_state]) ==
               "┌───┬───┬───┐\n│ X │ O │ X │\n├───┼───┼───┤\n│ O │ X │ O │\n├───┼───┼───┤\n│ X │ O │ X │\n└───┴───┴───┘"
    end
  end
end
