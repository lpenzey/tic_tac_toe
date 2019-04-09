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

  test "sets player move" do
    s = %State{}
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
               player: "X"
             }
  end
end
