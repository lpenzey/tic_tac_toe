defmodule State_Test do
  use ExUnit.Case
  doctest State

  test "creates State struct with player and empty board" do
    s = %State{}

    assert s.player == "X"

    assert s.board == %{
             {0, 0} => 1,
             {0, 1} => 2,
             {0, 2} => 3,
             {1, 0} => 4,
             {1, 1} => 5,
             {1, 2} => 6,
             {2, 0} => 7,
             {2, 1} => 8,
             {2, 2} => 9
           }
  end

  test "gets the board values" do
    s = %State{}

    assert State.get_board(s) == %{
             {0, 0} => 1,
             {0, 1} => 2,
             {0, 2} => 3,
             {1, 0} => 4,
             {1, 1} => 5,
             {1, 2} => 6,
             {2, 0} => 7,
             {2, 1} => 8,
             {2, 2} => 9
           }
  end

  test "gets the player symbol" do
    s = %State{}

    assert State.get_player(s) == "X"
  end

  test "switch player symbol from \"X\" to \"O\"" do
    s = %State{player: "X"}

    assert State.switch_player(s.player) == "O"
  end

  test "switch player symbol from \"O\" to \"X\"" do
    s = %State{player: "O"}

    assert State.switch_player(s.player) == "X"
  end

  test "sets player symbol \"X\" in board and switches player symbol to \"O\"" do
    s = %State{player: "X"}
    move = {0, 0}

    assert State.set_move(move, s) ==
             %State{
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
               player: "O"
             }
  end

  test "sets player symbol \"O\" in board and switches player symbol to \"X\"" do
    s = %State{player: "O"}
    move = {0, 0}

    assert State.set_move(move, s) ==
             %State{
               board: %{
                 {0, 0} => "O",
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
  end
end
