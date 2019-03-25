defmodule Input_Test do
  use ExUnit.Case
  doctest Input
  import ExUnit.CaptureIO

  test "approves user move that exists" do
    assert Input.valid?("1")
  end

  test "rejects user selection for space that doesn't exist" do
    assert Input.valid?("10") == false
  end

  test "rejects user input that isn't a number" do
    assert Input.number?("a") == false
  end

  test "accepts user input that is a number" do
    assert Input.number?("1")
  end

  test "approves user selection for unoccupied space" do
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

    assert Input.open?("2", s)
  end

  test "rejects user selection of occupied space" do
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

    assert Input.open?("1", s) == false
  end

  test "processes valid move into game state" do
    s = %State{
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
      }
    }

    assert Input.process_move("1", s) ==
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

  test "does not process move for an occupied spot" do
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

    space_taken = fn -> Input.process_move("1", s) end
    assert capture_io(space_taken) == "I'm sorry, that space is taken, please choose again\n"
  end

  test "does not process move for move that isn't a number" do
    s = %State{}
    not_a_number = fn -> Input.process_move("a", s) end
    assert capture_io(not_a_number) == "I'm sorry, that is not a number, please enter a number\n"
  end

  test "does not process move for a nonexistant space" do
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

    not_a_space = fn -> Input.process_move("10", s) end

    assert capture_io(not_a_space) ==
             "I'm sorry, that space doesn't exist on the board, please choose again\n"
  end
end
