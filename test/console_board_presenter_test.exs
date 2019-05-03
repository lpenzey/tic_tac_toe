defmodule ConsoleBoardPresenterTest do
  use ExUnit.Case
  doctest ConsoleBoardPresenter

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

    test "builds an empty 3x3 board", context do
      assert ConsoleBoardPresenter.build(context[:empty_board_state]) ==
               "┌───┬───┬───┐\n│ 1 │ 2 │ 3 │\n├───┼───┼───┤\n│ 4 │ 5 │ 6 │\n├───┼───┼───┤\n│ 7 │ 8 │ 9 │\n└───┴───┴───┘"
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

    test "builds a 3x3 board with a user move", context do
      assert ConsoleBoardPresenter.build(context[:one_move_board_state]) ==
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

    test "builds a 3x3 board with all moves completed", context do
      assert ConsoleBoardPresenter.build(context[:full_board_state]) ==
               "┌───┬───┬───┐\n│ X │ O │ X │\n├───┼───┼───┤\n│ O │ X │ O │\n├───┼───┼───┤\n│ X │ O │ X │\n└───┴───┴───┘"
    end
  end
end
