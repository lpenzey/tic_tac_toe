defmodule Board_test do
  use ExUnit.Case
  doctest Board

  test "gets initial game values from board getter" do
    s = %State{}
    assert Board.gen_values(s) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "gets game values from board getter with one move" do
    s = %State{
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
      }
    }

    assert Board.gen_values(s) == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "builds an empty 3x3 board" do
    s = %State{}

    assert Board.build(s) ==
             "┌───┬───┬───┐\n│ 1 │ 2 │ 3 │\n├───┼───┼───┤\n│ 4 │ 5 │ 6 │\n├───┼───┼───┤\n│ 7 │ 8 │ 9 │\n└───┴───┴───┘"
  end

  test "builds a 3x3 board with a user move" do
    s = %State{
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
      }
    }

    assert Board.build(s) ==
             "┌───┬───┬───┐\n│ X │ 2 │ 3 │\n├───┼───┼───┤\n│ 4 │ 5 │ 6 │\n├───┼───┼───┤\n│ 7 │ 8 │ 9 │\n└───┴───┴───┘"
  end

  test "builds a 3x3 board with all moves completed" do
    s = %State{
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
      }
    }

    assert Board.build(s) ==
             "┌───┬───┬───┐\n│ X │ O │ X │\n├───┼───┼───┤\n│ O │ X │ O │\n├───┼───┼───┤\n│ X │ O │ X │\n└───┴───┴───┘"
  end
end
