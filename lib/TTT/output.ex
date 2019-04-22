defmodule Output do
  def get_message(term) do
    messages = %{
      welcome: "Welcome to Tic Tac Toe!",
      choose: "Please choose a spot by entering 1 - 9: ",
      nonexistant_space: "I'm sorry, that space doesn't exist on the board, please choose again",
      space_taken: "I'm sorry, that space is taken, please choose again",
      nan: "I'm sorry, that is not a number, please enter a number",
      tie: "The game is a tie!",
      opponent_move: "Opponent's turn:"
    }

    messages[term]
  end

  def display_board(state, _client \\ :console) do
    IO.puts(ConsoleBoardPresenter.build(state))
    state
  end

  def welcome do
    IO.puts(Output.get_message(:welcome))
  end

  def display_message(state, message) do
    IO.puts(Output.get_message(message))
    state
  end

  def end_of_game(state) do
    cond do
      Status.win?(State.get_board(state)) ->
        winner = Status.winner(State.get_board(state))
        IO.puts("Congratulations to #{winner} for winning the game!")

      Status.tie?(State.get_board(state)) ->
        IO.puts(get_message(:tie))
    end
  end
end
