defmodule Messages do
  def get_message(term) do
    messages = %{
      welcome: "Welcome to Tic Tac Toe!",
      choose: " - please choose a spot by entering 1 - 9: ",
      choose_token: "Please choose your symbol: ",
      choose_opponent_token: "Please choose the opponent's symbol: ",
      choose_mode:
        "Please choose game mode\nEnter \"1\" to play against a friend\nEnter \"2\" to play against an easy computer\nEnter \"3\" to play against an unbeatable computer: ",
      nonexistant_space: "I'm sorry, that space doesn't exist on the board, please choose again",
      space_taken: "I'm sorry, that space is taken, please choose again",
      nan: "I'm sorry, that is not a number, please enter a number",
      tie: "The game is a tie!",
      opponent_move: "Opponent's turn:",
      winner: " is the winner of this game!",
      same_token: "Please enter a unique symbol",
      token_length_error: "Please choose a token that is 1 character long"
    }

    messages[term]
  end

  def display_board(io, state) do
    io.display(ConsoleBoardPresenter.build(state))
  end

  def display_message(io, message) do
    io.display(get_message(message))
  end

  def end_of_game(io, state) do
    cond do
      Status.win?(State.get_board(state)) ->
        winner = Status.winner(State.get_board(state))
        io.display("#{winner}" <> get_message(:winner))

      Status.tie(State.get_board(state)) ->
        io.display(get_message(:tie))
    end
  end
end
