defmodule Input_Test do
  use ExUnit.Case
  doctest Input
  import ExUnit.CaptureIO

  test "cleans newline character from user input" do
    assert Input.clean("1\n") == "1"
  end

  test "processes valid move to enter \"X\" into board and switches player to \"O\"" do
    s = %State{}

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
               player: "O"
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
end
