defmodule Messages do
  @input_output Application.get_env(:tic_tac_toe, :console_io)

  def get_message(term) do
    messages = %{
      welcome: "Welcome to Tic Tac Toe!",
      choose: "Please choose a spot by entering 1 - 9: ",
      choose_token: "Please choose your token (enter \"X\" or \"O\"): ",
      choose_mode:
        "Please choose game mode\nEnter \"1\" to play against a friend\nEnter \"2\" to play against the computer: ",
      nonexistant_space: "I'm sorry, that space doesn't exist on the board, please choose again",
      space_taken: "I'm sorry, that space is taken, please choose again",
      nan: "I'm sorry, that is not a number, please enter a number",
      tie: "The game is a tie!",
      opponent_move: "Opponent's turn:"
    }

    messages[term]
  end

  def display_board(state, _client \\ :console) do
    @input_output.puts(ConsoleBoardPresenter.build(state))
    state
  end

  def welcome do
    @input_output.puts(get_message(:welcome))
  end

  def display_message(state, message) do
    @input_output.puts(get_message(message))
    state
  end

  def end_of_game(state) do
    cond do
      Status.win?(State.get_board(state)) ->
        winner = Status.winner(State.get_board(state))
        @input_output.puts("Congratulations to #{winner} for winning the game!")

      Status.tie(State.get_board(state)) ->
        @input_output.puts(get_message(:tie))
    end
  end
end
