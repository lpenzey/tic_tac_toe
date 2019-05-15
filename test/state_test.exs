defmodule StateTest do
  use ExUnit.Case
  doctest State

  setup do
    %{empty_board_state: %State{player: "X", opponent: "O", current_player: "X"}}
  end

  test "State struct is created with an empty board", context do
    assert context[:empty_board_state].board == %{
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

  test "State struct is created with player symbol \"X\"", context do
    assert context[:empty_board_state].player == "X"
  end

  test "State struct is created with opponent symbol \"O\"", context do
    assert context[:empty_board_state].opponent == "O"
  end

  test "State struct is created with current player \"X\"", context do
    assert context[:empty_board_state].current_player == "X"
  end

  test "gets the board values", context do
    assert State.get_board(context[:empty_board_state]) == %{
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

  test "gets the player symbol", context do
    assert State.get_player(context[:empty_board_state]) == "X"
  end

  test "gets the opponent symbol", context do
    assert State.get_opponent(context[:empty_board_state]) == "O"
  end

  test "swaps board keys and values", context do
    assert State.invert(context[:empty_board_state]) == %{
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

  test "sets player symbol \"X\" in board and switches current_player symbol to \"O\"", context do
    move = {0, 0}

    assert State.set_move(move, context[:empty_board_state]) ==
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
               player: "X",
               opponent: "O",
               current_player: "O"
             }
  end

  test "sets opponent symbol \"O\" in board and switches curent_player to \"X\"" do
    one_move_state = %State{
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
      player: "X",
      opponent: "O",
      current_player: "O"
    }

    move = {0, 1}

    assert State.set_move(move, one_move_state) ==
             %State{
               board: %{
                 {0, 0} => "X",
                 {0, 1} => "O",
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
               current_player: "X"
             }
  end

  test "switches current player from X to O", context do
    assert State.switch_player(context[:empty_board_state]) == "O"
  end
end
