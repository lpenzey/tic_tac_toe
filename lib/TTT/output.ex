defmodule Output do
  def get_message(term) do
    messages = %{
      welcome: "Welcome to Tic Tac Toe!",
      choose: "Please choose a spot by entering 1 - 9",
      nonexistant_space: "I'm sorry, that space doesn't exist on the board, please choose again",
      space_taken: "I'm sorry, that space is taken, please choose again",
      nan: "I'm sorry, that is not a number, please enter a number"
    }

    messages[term]
  end

  def print_board(state, _client \\ :console) do
    IO.puts(Board.build(state))
    state
  end

  def welcome(:console) do
    IO.puts(Output.get_message(:welcome))
    IO.puts(Output.get_message(:choose))
  end
end
